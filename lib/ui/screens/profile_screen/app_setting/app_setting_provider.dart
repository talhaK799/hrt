import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/splash_screen.dart';

class AppSettingProvider extends BaseViewModel {
  bool isNotificationsOn = false;
  final _auth = locator<AuthService>();
  final _db = DatabaseService();
  changeNotificaionSettin(val) async {
    isNotificationsOn = val;
    notifyListeners();
    _auth.appUser.isNotificationsOn = val;
    await _db.updateUserProfile(_auth.appUser);
  }

  terminateUser() async {
    setState(ViewState.busy);
    await _auth.deleteUserAccount();
    Get.offAll(
      SplashScreen(),
    );
    setState(ViewState.idle);
  }
}
