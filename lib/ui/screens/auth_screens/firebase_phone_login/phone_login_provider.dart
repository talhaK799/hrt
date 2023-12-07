import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/services/verification_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/opt_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';

class PhoneLoginProvider extends BaseViewModel {
  final authService = locator<AuthService>();
  // AppUser appUser = AppUser();
  final verificationService = locator<VerificationService>();
  final locationService = locator<LocationService>();
  TextEditingController otpController = TextEditingController();

  CustomAuthResult customAuthResult = CustomAuthResult();
  Position? currentLocation;
  List<Placemark> placemarks = [];
  final formKey = GlobalKey<FormState>();
  String verificationId = '';
  late Timer _timer;
  bool isResend = false;
  bool isEnable = false;

  int otpTime = 60;

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
    // setState(ViewState.busy);

    // if(currentPostion!.latitude!=null){}
    placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    // setState(ViewState.idle);

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

      // setState(ViewState.busy);
      bool isSent = await authService.verifyPhoneNumber(
        appUser.phoneNumber!,
        codeSent: (String verificationId, int? resendToken) {
          authService.verificationId = verificationId;
          this.verificationId = verificationId;
          print("codeSent verificationId ===> $verificationId");
          // customSnackBar(context, "SMS Code Sent");
          isResend = false;

          notifyListeners();

          authService.resendToken = resendToken;
        },
      );
      // setState(ViewState.idle);
      if (isSent) {
        startTimer();
        if (!isResend) {
          Get.to(() => OtpVerificationScreen());
        }
        isEnable = false;
        notifyListeners();
      } else {
        Get.snackbar("Error!", "Please try again");
      }
      // startTimer();
      // if (!isResend) {
      //   Get.to(() => OtpVerificationScreen());
      // }
      // isEnable = false;
      notifyListeners();
    }
  }

  verifyPhoneOtp() async {
    if (otpController.text == '') {
      Get.snackbar('Error!!', "Otp must be entered");
    } else {
      _timer.cancel();
      notifyListeners();
      // setState(ViewState.busy);
      customAuthResult = await authService.loginWithPhoneNumber(
        appUser,
        appUser.phoneNumber!,
        phoneOtp,
      );
      if (customAuthResult.user != null) {
        _timer.cancel();
        notifyListeners();
        authService.appUser.isPhoneNoVerified = true;
        Get.to(DOBScreen());
        Get.to(
          DOBScreen(),
        );
      }
      // setState(ViewState.idle);
    }
  }

  void startTimer() async {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (otpTime == 0) {
          timer.cancel();
          print("When time 0 Second ====> $otpTime");
          // isTimeExpired = true;
          isResend = true;
          isEnable = true;
          otpTime = 5;
          // isSent = false;
          // print("Second ====> $otpTime ==>$isTimeExpired");
          notifyListeners();
        } else {
          otpTime--;
          print("otpTime: $otpTime");
          notifyListeners();
        }
      },
    );
  }
}
