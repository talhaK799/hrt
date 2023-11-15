import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/custom_auth_result.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';

class AuthProvider extends BaseViewModel {
  final _auth = locator<AuthService>();
  CustomAuthResult authResult = CustomAuthResult();
  // final _db = DatabaseService();

  signInWithGoogle(context) async {
    setState(ViewState.busy);
    authResult = await _auth.signUpUserWithGoogle();
    setState(ViewState.idle);
    if (authResult.user != null) {
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

  signInWithFacebook(context) async {
    setState(ViewState.busy);
    authResult = await _auth.signupWithFacebook();
    setState(ViewState.idle);
    if (authResult.appuser!.id != null) {
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
}
