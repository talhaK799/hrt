import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/services/verification_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/opt_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/email_verification_screen.dart';

class PhoneLoginProvider extends BaseViewModel {
  final authService = locator<AuthService>();
  // AppUser appUser = AppUser();
  final verificationService = locator<VerificationService>();
  final locationService = locator<LocationService>();

  CustomAuthResult customAuthResult = CustomAuthResult();
  Position? currentLocation;
  List<Placemark> placemarks = [];
  final formKey = GlobalKey<FormState>();
  String verificationId = '';

  // DatabaseService _databaseService = DatabaseService();

  PhoneLoginProvider() {
    init();
  }

  init() async {
    currentLocation = await locationService.determinePosition();
    await convertLatAndLongIntoAddress();
    initialCountry = placemarks.first.country!;
  }

  convertLatAndLongIntoAddress() async {
    placemarks = [];
    setState(ViewState.busy);

    // if(currentPostion!.latitude!=null){}
    placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    setState(ViewState.idle);

    print("country =>" + placemarks.first.country!);
  }

  AppUser appUser = AppUser();
  String phoneOtp = '';
  String? initialCountry;

  String countryCode = "+92";
  selectCountryCode(val) {
    countryCode = val.toString();
    print('Country ==> $countryCode');
    notifyListeners();
  }

  sentOTP() async {
    if (appUser.phoneNumber != null || countryCode.isNotEmpty) {
      // isTimeExpired = false;
      appUser.phoneNumber = countryCode + appUser.phoneNumber!;
      print("Phone number ==> ${appUser.phoneNumber}");

      setState(ViewState.busy);
      bool isSent = await authService.verifyPhoneNumber(
        appUser.phoneNumber!,
        codeSent: (String verificationId, int? resendToken) {
          authService.verificationId = verificationId;
          this.verificationId = verificationId;
          print("codeSent verificationId ===> $verificationId");
          // customSnackBar(context, "SMS Code Sent");
          // isResend = false;

          notifyListeners();

          authService.resendToken = resendToken;
        },
      );
      setState(ViewState.idle);
      if (isSent) {
        Get.to(() => OtpVerificationScreen());
      } else {
        Get.snackbar("Error!", "Please try again");
      }
      // startTimer();
      notifyListeners();
    }
  }

  verifyPhoneOtp() async {
    setState(ViewState.busy);
    customAuthResult = await authService.loginWithPhoneNumber(
      appUser,
      appUser.phoneNumber!,
      phoneOtp,
    );
    if (customAuthResult.user != null) {
      authService.appUser.isPhoneNoVerified = true;
      Get.to(DOBScreen());
      // Get.to(
      //   EmailVerificationScreen(
      //     isPhoneLogin: true,
      //   ),
      // );
    }
    setState(ViewState.idle);
    // var msg = await verificationService.verifyPhoneNumber(
    //     authService.appUser.phoneNumber, phoneOtp);
    // print("msg ==>$msg");

    // if (msg == "Phone number is verified") {
    //   // // _timer.cancel();
    //   // // _timer.cancel();
    //   authService.appUser.isPhoneNoVerified = true;
    //   authService.appUser.phoneNumber = countryCode + appUser.phoneNumber!;

    //   bool isUpdatedProfile =
    //       await _databaseService.updateUserProfile(authService.appUser);
    //   setState(ViewState.idle);
    //   if (isUpdatedProfile) {
    //     Get.to(
    //       DOBScreen(),
    //     );
    //   }
    // }
  }
}