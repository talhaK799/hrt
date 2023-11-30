import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';

class AuthProvider extends BaseViewModel {
  final _auth = locator<AuthService>();
  final db = DatabaseService();
  CustomAuthResult authResult = CustomAuthResult();
  // final _db = DatabaseService();

  signInWithGoogle(context) async {
    print("Signin");
    setState(ViewState.busy);
    authResult = await _auth.signUpUserWithGoogle();
    setState(ViewState.idle);
    if (authResult.user != null) {
      _auth.appUser.isGoogle = true;
      profileUpdate();
      Get.to(
        DOBScreen(),
      );
    } else {
      showMyDialog(
        context,
        authResult.errorMessage!,
      );
    }
  }

  loginWithApple(context) async {
    print("login with Apple");

    setState(ViewState.busy);
    try {
      authResult = await _auth.signUpUserWithApple();
      setState(ViewState.idle);
      if (authResult.user != null) {
        _auth.appUser.isGoogle = true;
        profileUpdate();
        Get.to(
          DOBScreen(),
        );
      } else {
        showMyDialog(
          context,
          authResult.errorMessage!,
        );
      }
      setState(ViewState.idle);
    } catch (e) {
      print("Erro: $e");
    }
  }

  signInWithFacebook(context) async {
    setState(ViewState.busy);
    authResult = await _auth.signupWithFacebook();
    setState(ViewState.idle);
    if (authResult.appuser!.id != null) {
      _auth.appUser.isFacebook = true;
      profileUpdate();
      Get.to(
        DOBScreen(),
      );
    } else {
      showMyDialog(
        context,
        authResult.errorMessage,
      );
    }
  }

  profileUpdate() async {
    await db.updateUserProfile(_auth.appUser);
  }
}
