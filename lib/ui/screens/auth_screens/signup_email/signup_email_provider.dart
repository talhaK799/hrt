// import 'package:encrypt/encrypt.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/code_confirmation_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/email_verification_screen.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/view_models/base_view_model.dart';

class SignUpwithEmailProvider extends BaseViewModel {
  // bool isSelected = false;
  final formKey = GlobalKey<FormState>();
  CustomAuthResult authResult = CustomAuthResult();
  final authService = locator<AuthService>();
  bool isVisible = true;
  bool isConfirVisibe = true;
  AppUser appuser = AppUser();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  EmailOTP emailOTP = EmailOTP();
  // double passwordLength = 8.0;

  signUp(context) async {
    setState(ViewState.busy);
    authResult = await authService.signUpWithEmailPassword(appuser);
    if (authResult.user != null) {
      await sendotptoEmail();
      setState(ViewState.idle);
      // Get.to(
      //   EmailVerificationScreen(),
      // );
    } else {
      showMyDialog(
        context,
        authResult.errorMessage!,
      );
    }

    setState(ViewState.idle);
  }

  toggleVisibilty() {
    isVisible = !isVisible;
    notifyListeners();
  }

  toggleConfirmVisibilty() {
    isConfirVisibe = !isConfirVisibe;
    notifyListeners();
  }

  sendotptoEmail() async {
    emailOTP = EmailOTP();

    print(appuser.email);
    // setState(ViewState.busy);
    await emailOTP.setConfig(
        appEmail: "infohartapp@gmail.com",
        appName: "Hart",
        userEmail: appuser.email,
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    // setState(ViewState.idle);
    bool isOTPSend = await emailOTP.sendOTP();

    if (isOTPSend) {
      Get.snackbar("Success!", "OTP sent to your email");
      Get.to(
        EmailOtpScreen(
          emailOTP: emailOTP,
        ),
      );

      notifyListeners();
      // startTimer();
      // otp = myauth.toString();
      // print("OTP sent ==> ${myauth.toString()}");
    } else {
      print("Oops, OTP send failed");
      Get.snackbar("Error!", "Send again opt");
    }
    // await _verificationService.sendCodeToEmail();
    // print("${_verificationService.twilioResponse.statusCode}");
  }
}



// Future<void> _showMyDialog(context, String? error) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Alert'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('${error!}'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
