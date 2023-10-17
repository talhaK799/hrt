import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/services/verification_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';

import 'phone_code_confirmation_screen.dart';

class PhoneNoProvider extends BaseViewModel {
  final authService = locator<AuthService>();
  final verificationService = locator<VerificationService>();
  final locationService = locator<LocationService>();
  Position? currentLocation;
  List<Placemark> placemarks = [];
  final formKey = GlobalKey<FormState>();

  DatabaseService _databaseService = DatabaseService();

  PhoneNoProvider() {
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
      authService.appUser.phoneNumber = countryCode + appUser.phoneNumber!;
      print("Phone number ==> ${authService.appUser.phoneNumber}");
      await verificationService.sendVerificationCodeThroughPhoneNumber(
          authService.appUser.phoneNumber!);
      Get.to(() => PhoneCodeConfirmationScreen());
      // startTimer();
      notifyListeners();
    }
  }

  verifyPhoneOtp() async {
    var msg = await verificationService.verifyPhoneNumber(
        authService.appUser.phoneNumber, phoneOtp);
    print("msg ==>$msg");

    if (msg == "Phone number is verified") {
      // // _timer.cancel();
      // setState(ViewState.busy);
      // // _timer.cancel();
      authService.appUser.isPhoneNoVerified = true;
      authService.appUser.phoneNumber = countryCode + appUser.phoneNumber!;

      bool isUpdatedProfile =
          await _databaseService.updateUserProfile(authService.appUser);
      setState(ViewState.idle);
      if (isUpdatedProfile) {
        Get.to(
          DOBScreen(),
        );
      }
    }
  }
}
