// import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/email_verification_screen.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/view_models/base_view_model.dart';

class SignUpwithEmailProvider extends BaseViewModel {
  // bool isSelected = false;
  final formKey = GlobalKey<FormState>();
  CustomAuthResult authResult = CustomAuthResult();
  final authService = locator<AuthService>();
  bool isVisible = false;
  bool isConfirVisibe = false;
  AppUser appuser = AppUser();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // double passwordLength = 8.0;

  signUp(context) async {
    setState(ViewState.busy);
    authResult = await authService.signUpWithEmailPassword(appuser);

    setState(ViewState.idle);
    if (authResult.user != null) {
    Get.to(
      EmailVerificationScreen(),
    );
    } else {
      showMyDialog(
        context,
        authResult.errorMessage!,
      );
    }

    notifyListeners();
  }

  toggleVisibilty() {
    isVisible = !isVisible;
    notifyListeners();
  }

  toggleConfirmVisibilty() {
    isConfirVisibe = !isConfirVisibe;
    notifyListeners();
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
