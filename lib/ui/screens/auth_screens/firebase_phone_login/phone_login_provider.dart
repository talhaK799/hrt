// import 'dart:async';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:hart/core/enums/view_state.dart';
// import 'package:hart/core/models/app_user.dart';
// import 'package:hart/core/models/custom_auth_result.dart';
// import 'package:hart/core/services/auth_service.dart';
// import 'package:hart/core/services/location_service.dart';
// import 'package:hart/core/services/verification_service.dart';
// import 'package:hart/core/view_models/base_view_model.dart';
// import 'package:hart/locator.dart';
// import 'package:hart/ui/custom_widgets/right_navigation.dart';
// import 'package:hart/ui/screens/auth_screens/firebase_phone_login/opt_screen.dart';
// import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
// import 'package:hart/ui/screens/root_screen/root_screen.dart';

// class PhoneLoginProvider extends BaseViewModel {
//   final authService = locator<AuthService>();
//   // AppUser appUser = AppUser();
//   final verificationService = locator<VerificationService>();
//   final locationService = locator<LocationService>();
//   TextEditingController otpController = TextEditingController();

//   CustomAuthResult customAuthResult = CustomAuthResult();
//   Position? currentLocation;
//   List<Placemark> placemarks = [];
//   final formKey = GlobalKey<FormState>();
//   String verificationId = '';
//   late Timer _timer;
//   bool isResend = false;
//   bool isEnable = false;

//   int otpTime = 60;

//   // DatabaseService _databaseService = DatabaseService();

//   PhoneLoginProvider() {
//     init();
//   }

//   init() async {
//     currentLocation = await locationService.determinePosition();
//     await convertLatAndLongIntoAddress();
//     initialCountry = placemarks.first.country!;
//   }

//   List<String> preferredCountries = [
//     'Italia',
//     'United Kingdom',
//     'United States'
//   ];

// // Define a function to compare two countries
//   int compareCountries(CountryCode c1, CountryCode c2) {
//     // Get the index of each country in the preferred list, or -1 if not found
//     int indexA = preferredCountries.indexOf(c1.name!);
//     int indexB = preferredCountries.indexOf(c2.name!);

//     // If both countries are in the preferred list, compare their indices
//     if (indexA != -1 && indexB != -1) {
//       return indexA.compareTo(indexB);
//     }
//     // If only one country is in the preferred list, put it first
//     else if (indexA != -1) {
//       return -1;
//     } else if (indexB != -1) {
//       return 1;
//     }
//     // If neither country is in the preferred list, use the default order
//     else {
//       return c1.name!.compareTo(c2.name!);
//     }
//   }

//   convertLatAndLongIntoAddress() async {
//     placemarks = [];
//     // setState(ViewState.busy);

//     // if(currentPostion!.latitude!=null){}
//     placemarks = await placemarkFromCoordinates(
//         currentLocation!.latitude, currentLocation!.longitude);
//     // setState(ViewState.idle);

//     print("country =>" + placemarks.first.country!);
//   }

//   AppUser appUser = AppUser();
//   String phoneOtp = '';
//   String? initialCountry;

//   String countryCode = "+92";
//   selectCountryCode(val) {
//     countryCode = val.toString();
//     print('Country ==> $countryCode');
//     notifyListeners();
//   }

//   sentOTP(context, isResend) async {
//     if (appUser.phoneNumber != null || countryCode.isNotEmpty) {
//       // isTimeExpired = false;

//       if (isResend == false) {
//         appUser.phoneNumber = countryCode + appUser.phoneNumber!;
//         print("Phone number ==> ${appUser.phoneNumber}");
//       }

//       // setState(ViewState.busy);
//       setState(ViewState.busy);
//       bool isSent = await verificationService
//           .sendVerificationCodeThroughPhoneNumber(appUser.phoneNumber!);
//       setState(ViewState.idle);

//       // setState(ViewState.idle);
//       if (isSent) {
//         startTimer();
//         if (!isResend) {
//           Navigator.push(
//             context,
//             PageFromRight(
//               page: OtpVerificationScreen(),
//             ),
//           );
//         }
//         isEnable = false;
//         notifyListeners();
//       } else {
//         Get.snackbar("Error!", "Please try again");
//       }
//       // startTimer();
//       // if (!isResend) {
//       //   Get.to(() => OtpVerificationScreen());
//       // }
//       // isEnable = false;
//       notifyListeners();
//     }
//   }

//   verifyPhoneOtp(context) async {
//     if (otpController.text == '') {
//       Get.snackbar('Error!!', "Otp must be entered");
//     } else {
//       _timer.cancel();
//       notifyListeners();

//       ///
//       ///
//       setState(ViewState.busy);
//       var msg = await verificationService.verifyPhoneNumber(
//           authService.appUser.phoneNumber, phoneOtp);
//       setState(ViewState.idle);
//       print("msg ==>$msg");

//       if (msg == "Phone number is verified") {
//         print("verify ====> $msg");
//         authService.appUser.isPhoneNoVerified = true;
//         authService.appUser.phoneNumber = countryCode + appUser.phoneNumber!;

//         // _databaseService.updateUserProfile(authService.appUser);
//       }
//       // if (authService.appUser.isProfileCompleted == true) {
//       //   Navigator.push(
//       //     context,
//       //     PageFromRight(
//       //       page: RootScreen(),
//       //     ),
//       //   );
//       // } else {
//       //   Navigator.push(
//       //     context,
//       //     PageFromRight(
//       //       page: DOBScreen(),
//       //     ),
//       //   );
//       // }

//       ///
//       ///
//       ///
//       ///

//       // setState(ViewState.busy);
//       // customAuthResult = await authService.loginWithPhoneNumber(
//       //   appUser,
//       //   appUser.phoneNumber!,
//       //   phoneOtp,
//       // );
//       // if (customAuthResult.user != null) {
//       //   _timer.cancel();
//       //   notifyListeners();
//       //   authService.appUser.phoneNumber = appUser.phoneNumber;
//       //   authService.appUser.isPhoneNoVerified = true;
//       //   // Get.to(DOBScreen());
//       //   // Get.to(
//       //   //   DOBScreen(),
//       //   // );
//       //   if (authService.appUser.isProfileCompleted == true) {
//       //     Navigator.push(
//       //       context,
//       //       PageFromRight(
//       //         page: RootScreen(),
//       //       ),
//       //     );
//       //   } else {
//       //     Navigator.push(
//       //       context,
//       //       PageFromRight(
//       //         page: DOBScreen(),
//       //       ),
//       //     );
//       //   }
//       // }
//       // setState(ViewState.idle);
//     }
//   }

//   void startTimer() async {
//     const oneSecond = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSecond,
//       (Timer timer) {
//         if (otpTime == 0) {
//           timer.cancel();
//           print("When time 0 Second ====> $otpTime");
//           // isTimeExpired = true;
//           isResend = true;
//           isEnable = true;
//           otpTime = 5;
//           // isSent = false;
//           // print("Second ====> $otpTime ==>$isTimeExpired");
//           notifyListeners();
//         } else {
//           otpTime--;
//           print("otpTime: $otpTime");
//           notifyListeners();
//         }
//       },
//     );
//   }
// }
