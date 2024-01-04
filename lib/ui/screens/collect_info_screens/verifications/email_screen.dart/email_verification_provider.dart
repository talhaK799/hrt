import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:email_otp/email_otp.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/code_confirmation_screen.dart';

class EmailVerificationProvider extends BaseViewModel {
  String email = '';
  String phoneOtp = '';
  EmailOTP emailOTP = EmailOTP();
  bool isPhone = false;
  final formKey = GlobalKey<FormState>();

  // TextEditingController pinController = TextEditingController();
  EmailVerificationProvider(phone) {
    isPhone = phone;
  }
  final authService = locator<AuthService>();
  // CustomAuthResult customAuthResult = CustomAuthResult();
  // DatabaseService _databaseService = DatabaseService();

  sendotptoEmail(context) async {
    // emailOTP = EmailOTP();
    // Get.to(
    //   EmailOtpScreen(
    //     emailOTP: emailOTP,
    //     isphone: isPhone,
    //   ),
    // );
    Navigator.push(
      context,
      PageFromRight(
        page: EmailOtpScreen(
          emailOTP: emailOTP,
          isphone: isPhone,
        ),
      ),
    );

    // print(email);
    // setState(ViewState.busy);
    // await emailOTP.setConfig(
    //     appEmail: "talhakhurshed799@gmail.com",
    //     appName: "Hart",
    //     userEmail: email,
    //     otpLength: 4,
    //     otpType: OTPType.digitsOnly);
    // bool isOTPSend = await emailOTP.sendOTP();

    // setState(ViewState.idle);

    // if (isOTPSend) {
    //   Get.snackbar("Success!", "OTP sent to your email");
    //   Get.to(
    //     EmailOtpScreen(
    //       emailOTP: emailOTP,
    //       isphone: isPhone,
    //     ),
    //   );
    //   // startTimer();
    //   // otp = myauth.toString();
    //   // print("OTP sent ==> ${myauth.toString()}");
    // } else {
    //   print("Oops, OTP send failed");
    //   Get.snackbar("Error!", "Send again opt");
    // }
    // await _verificationService.sendCodeToEmail();
    // print("${_verificationService.twilioResponse.statusCode}");
  }

  // verifyOtp() async {
  //   setState(ViewState.busy);
  //   bool isVerify = await emailOTP.verifyOTP(otp: phoneOtp);
  //   setState(ViewState.idle);

  //   if (isVerify == true) {
  //     authService.appUser.isEmailVerified = true;

  //     setState(ViewState.busy);
  //     await _databaseService.updateUserProfile(authService.appUser);
  //     setState(ViewState.idle);

  //     Get.to(
  //       AddPhoneNumberScreen(),
  //     );
  //   } else {
  //     Get.snackbar("Error!", "Invalid OTP");
  //   }
  // }
}
