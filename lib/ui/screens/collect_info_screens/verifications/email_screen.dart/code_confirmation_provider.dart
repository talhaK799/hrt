// import 'package:hart/core/view_models/base_view_model.dart';

// import '../../../../../core/enums/view_state.dart';

// class CodeConfirmationProvider extends BaseViewModel {
//   String? phoneNo = '';
  


//   verifyOtp() async {
//     setState(ViewState.busy);
//     bool isVerify = await emailOTP.verifyOTP(otp: phoneOtp);
//     setState(ViewState.idle);

//     if (isVerify == true) {
//       authService.appUser.isEmailVerified = true;

//       setState(ViewState.busy);
//       await _databaseService.updateUserProfile(authService.appUser);
//       setState(ViewState.idle);

//       // Get.to(PhoneNumberScreen());
//     } else {
//       Get.snackbar("Error!", "Invalid OTP");
//     }
//   }
// }
