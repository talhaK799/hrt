import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/splash_screen.dart';

class ProfileProvider extends BaseViewModel {
  final _auth = locator<AuthService>();
  logout() async {
    setState(ViewState.busy);
    await _auth.logout();
    Get.offAll(
      SplashScreen(),
    );
    setState(ViewState.idle);
  }
}
