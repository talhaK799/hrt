import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/models/subscripton.dart';
import 'package:hart/core/others/dynamic_link_handler.dart';
import 'auth_exception_service.dart';
import 'database_service.dart';

class AuthService extends ChangeNotifier {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;

  final link = DynamicLinkHandler();
  CustomAuthResult customAuthResult = CustomAuthResult();
  User? user;
  bool isLogin = false;
  AppUser appUser = AppUser();
  AppUser sharingUser = AppUser();
  AppUser signUpUser = AppUser();
  Subscription subscription = Subscription();

  GoogleSignIn googleSignIn = GoogleSignIn();

  Matches match = Matches();
  String? id;

  String? verificationId;
  int? resendToken;

  AuthService() {
    init();
  }
  init() async {
    user = _auth.currentUser;
    if (user != null) {
      isLogin = true;
      print('current User==> ${_auth.currentUser!.uid}');
      appUser = (await _dbService.getAppUser(user!.uid));
      if (appUser.id == null) {
        isLogin = false;
      } else {
        await checkLinkUser();
      }
      if (this.appUser.isPremiumUser == true) {
        await checkUserPremium();
      }
    } else {
      isLogin = false;
    }
  }

  ///
  /// check if user is entered the through link
  ///
  checkLinkUser() async {
    id = await link.initDeepLinks();
    if (id != null) {
      sharingUser = await _dbService.getAppUser(id);
      if (sharingUser.id != null) {
        if (!appUser.likedUsers!.contains(id)) {
          appUser.likedUsers!.add(id!);
          if (!sharingUser.likedUsers!.contains(appUser.id)) {
            sharingUser.likedUsers!.add(appUser.id!);
            match.createdAt = DateTime.now();
            match.isAccepted = true;
            match.isProgressed = true;
            match.isRejected = false;
            match.likedByUserId = this.appUser.id;
            match.likedUserId = sharingUser.id;
            await _dbService.updateUserProfile(appUser);
            await _dbService.updateUserProfile(sharingUser);
            await _dbService.addRequest(match);
          }
        }
      }
    }
  }

  checkUserPremium() async {
    if (appUser.paymentId == null) {
      print("not a Premium User");
    } else {
      subscription = await _dbService.checkPremiumExpire(this.appUser);
      if (subscription.type == "month") {
        final now = DateTime.now();
        final difference = now.difference(subscription.expiredAt!).inDays;
        print("Difference ===> $difference");

        if (difference >= 0) {
          this.appUser.isPremiumUser = false;
          this.appUser.paymentId = null;
          await _dbService.updateUserProfile(this.appUser);
        }
      }
      if (subscription.type == "3 months") {
        final now = DateTime.now();
        final difference = now.difference(subscription.expiredAt!).inDays;
        print("Difference ===> $difference");
        if (difference >= 0) {
          this.appUser.isPremiumUser = false;
          this.appUser.paymentId = null;
          await _dbService.updateUserProfile(this.appUser);
          print("Profile updated ===> ${this.appUser.isPremiumUser}");
        }
      }
      if (subscription.type == "year") {
        final now = DateTime.now();
        final difference = now.difference(subscription.expiredAt!).inDays;
        print("Difference ===> $difference");
        if (difference >= 0) {
          this.appUser.isPremiumUser = false;
          this.appUser.paymentId = null;
          await _dbService.updateUserProfile(this.appUser);
          print("Profile updated ===> ${this.appUser.isPremiumUser}");
        }
      }
    }
  }

  /// [SignUp] with email and password function
  ///
  signUpWithEmailPassword(AppUser appUser) async {
    debugPrint('@services/singUpWithEmailPassword');
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: appUser.email!, password: appUser.password!);

      /// If user signup fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        appUser.id = credentials.user!.uid;

        this.appUser = appUser;

        await _dbService.registerAppUser(appUser);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  /// [Login] with email and password function
  ///
  loginWithEmailPassword({email, password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }

      ///
      /// If firebase auth is successful:
      ///
      if (credentials.user != null) {
        appUser = await _dbService.getAppUser(credentials.user!.uid);
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
      }
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  /// phone number verification
  ///

  Future<bool> verifyPhoneNumber(String phoneNumber, {final codeSent}) async {
    try {
      await _auth
          .verifyPhoneNumber(
            forceResendingToken: this.resendToken,
            phoneNumber: phoneNumber.trim(),
            timeout: const Duration(seconds: 60),
            verificationCompleted:
                (PhoneAuthCredential phoneAuthCredential) async {
              // print("Verification Completed");
              // var result =
              //     await _auth.signInWithCredential(phoneAuthCredential);
              // print("RESULT::::: $result");
              // firebaseUser = result.user;
              // init();
            },
            verificationFailed: (FirebaseAuthException e) {
              print("Verification failed ==> $e");
            },
            codeSent: codeSent,
            codeAutoRetrievalTimeout: (String verificationId) {
              this.verificationId = verificationId;
              print("verificationId ===> $verificationId");
              print("verificationId ===> ${this.verificationId}");
            },
          )
          .onError((error, stackTrace) => throw "$error");
      return true;
    } catch (e) {
      print("Exception@verifyPhoneNumber ===> $e");
      return false;
    }
  }

  Future<CustomAuthResult> loginWithPhoneNumber(
      AppUser appUser, String phoneNumber, String smsCode) async {
    try {
      print("User phone number ===> $phoneNumber");
      print("User sms codde ===> $smsCode");
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId!,
        smsCode: smsCode.trim(),
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      this.user = userCredential.user;
      if (userCredential.user != null) {
        print("User logedin successfully with phone");

        notifyListeners();
        signUpUser = await _dbService.getAppUser(user!.uid);
        // checkAccount(id) async {
        if (signUpUser.id != null) {
          this.appUser = signUpUser;
        } else {
          appUser.id = userCredential.user!.uid;

          this.appUser = AppUser();
          await _dbService.registerAppUser(appUser);
        }
        // }

        customAuthResult.user = userCredential.user;
        customAuthResult.status = true;

        // if (signUpUser.id != null) {
        //   this.appUser = signUpUser;
        // customAuthResult.appUser = signUpUser;

        ///
        /// Add fcm token
        ///
        // this.appUser.fcmToken = await FirebaseMessaging.instance.getToken();
        // await _dbService.updateAppUser(this.appUser);
        // }
        // else if (signUpUser.id == null) {
        //   this.appUser = appUser;
        //   this.appUser.id = user!.uid;
        //   this.appUser.phoneNumber = phoneNumber;
        //   this.appUser.createdAt = DateTime.now();
        //   this.appUser.isProfileCompleted = false;
        //   this.appUser.interests = [];
        //   this.appUser.noOfLikes = 0;
        //   this.appUser.noOfMatches = 0;
        //   this.appUser.noOfViewers = 0;
        //   this.appUser.age = 0;
        //   this.appUser.defaultSwaps = 15;
        //   this.appUser.personality = [];
        //   this.appUser.address = Address();
        //   this.appUser.isPhoneVerified = false;
        //   this.appUser.isBlurImages = false;
        //   this.appUser.isEmailVerified = false;
        //   this.appUser.userIds = [];
        //   this.appUser.isPremiumUser = false;
        //   this.appUser.dobAt = DateTime.now();
        //   this.appUser.fcmToken = await FirebaseMessaging.instance.getToken();

        // customAuthResult.appUser = this.appUser;

        //   await _dbService.registerAppUser(appUser);
        // }
      }
      // customAuthResult.user = user;
      // customAuthResult.status = true;
    } catch (e) {
      print('Exception@siginInWithPhone ===> $e');
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  /// Google SignIn
  ///
  Future<CustomAuthResult> signUpUserWithGoogle() async {
    print("Signing with google");
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        print(
            "google access token==> ${googleSignInAuthentication.accessToken}");
        print("id token==> ${googleSignInAuthentication.idToken}");

        UserCredential result =
            await _auth.signInWithCredential(authCredential);
        user = result.user!;
        print('User email ${result.user!.email}');
        print('user id ${result.user!.uid}');
        print('User Name ${result.user!.displayName}');
        print('User imageUrl ${result.user!.photoURL}');
        this.appUser.id = result.user!.uid;

        signUpUser = await _dbService.getAppUser(result.user!.uid);
        if (signUpUser.id != null) {
          this.appUser = signUpUser;
          // this.appUser.fcmToken = await FirebaseMessaging.instance.getToken();
          // await _dbService.updateClientFcm(
          //     this.appUser.fcmToken, this.appUser.id);
        } else if (signUpUser.id == null) {
          this.appUser = AppUser();
          this.appUser.id = user!.uid;
          this.appUser.email = user!.email;
          this.appUser.name = user!.displayName;
          // this.appUser.images!.add(user!.photoURL!);

          await _dbService.registerAppUser(appUser);
        }
        customAuthResult.user = result.user!;
        customAuthResult.status = true;
      }
    } catch (e) {
      print("Exception@siginUpWithGoogle===>$e");
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  logout() async {
    await _auth.signOut();
    isLogin = false;
    user = null;
  }

  deleteUserAccount() async {
    await user!.delete();
    print('user id  ==> ${user!.uid}');
    isLogin = false;
    user = null;
  }
}

// signupWithFacebook() async {
//   //Todo: Do settings in the Google cloud for 0Auth Credentials
//   try {
//     final LoginResult result = await _facebookSignIn.login();
//     print('Facebook login => ${result.message}');
//     if (result.status == LoginStatus.success) {
//       print('Facebook login result success');
//       final AccessToken accessToken = result.accessToken!;
//       print("AccessToken::FaceAuth => ${accessToken.token}");
//       final firebaseAuthCred =
//           FacebookAuthProvider.credential(accessToken.token);
//       final loginResult =
//           await FirebaseAuth.instance.signInWithCredential(firebaseAuthCred);
//       final userData = await FacebookAuth.instance.getUserData();
//       this.clientUser = ClientUser();

//       /// Get user data
//       clientUser!.id = loginResult.user!.uid;
//       clientUser!.name = userData['name'];
//       clientUser!.email = userData['email'];
//       print(userData['picture']['data']['url']);
//       print('facebook login => ${clientUser!.name}');
//       customAuthResult.status = true;
//       customAuthResult.user = clientUser;
//       await _dbService.registerClient(clientUser!);

//       // Todo: Create Account in Database
//     } else {
//       customAuthResult.status = false;
//       customAuthResult.errorMessage = 'An undefined error happened.';
//     }
//   } catch (e) {
//     print('Exception @sighupWithFacebook: $e');
//     customAuthResult.status = false;
//     // customAuthResult.errorMessage =
//     //     AuthExceptionsService.generateExceptionMessage(e);
//   }
//   return customAuthResult;
// }


