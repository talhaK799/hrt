import 'package:email_otp/email_otp.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/phone_no_screen/add_phone_no.dart';

class EmailOtpProvider extends BaseViewModel {
  final authService = locator<AuthService>();
  final _databaseService = DatabaseService();
  EmailOTP? emailOTP;
  String emailCode = '';
  bool phone = false;

  EmailOtpProvider(otp, isphone) {
    phone = isphone;
    emailOTP = otp;
    notifyListeners();
  }
  verifyOtp() async {
    // setState(ViewState.busy);
    // bool isVerify = await emailOTP!.verifyOTP(otp: emailCode);
    // // setState(ViewState.idle);

    // if (isVerify == true) {
    //   authService.appUser.isEmailVerified = true;

    //   // setState(ViewState.busy);
    //   await _databaseService.updateUserProfile(authService.appUser);
    //   setState(ViewState.idle);
    if (phone == false) {
      Get.to(
        DOBScreen(),
      );
    } else {
      Get.to(
        AddPhoneNumberScreen(),
      );
    }
    // } else {
    //   Get.snackbar("Error!", "Invalid OTP");
    // }
  }
}
