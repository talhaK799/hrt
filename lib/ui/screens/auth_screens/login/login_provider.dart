import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class LoginProvider extends BaseViewModel {
  final AuthService authService = locator<AuthService>();
  CustomAuthResult authResult = CustomAuthResult();
  final fmkey = GlobalKey<FormState>();
  bool isvisible = true;
  AppUser appUser = AppUser();

  login(context) async {
    setState(ViewState.busy);
    authResult = await authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);

    setState(ViewState.idle);
    if (authResult.user != null) {
      if (authService.appUser.images == null) {
        Get.to(DOBScreen());
      } else if (authService.appUser.images!.isEmpty ||
          authService.appUser.isProfileCompleted == false) {
        Get.to(DOBScreen());
      } else {
        Get.offAll(RootScreen());
      }
      // Get.offAll(RootScreen());
    } else {
      showMyDialog(context, authResult.errorMessage);
    }

    notifyListeners();
  }

  toggleVisible() {
    isvisible = !isvisible;
    notifyListeners();
  }
}
