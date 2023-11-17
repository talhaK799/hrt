import 'package:get/get.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class UpliftPorvider extends BaseViewModel {
  final auth = locator<AuthService>();
  final _db = DatabaseService();
  upliftProfile() async {
    if (auth.appUser.isPremiumUser == true) {
      auth.appUser.uplift = DateTime.now();
      bool update = await _db.updateUserProfile(auth.appUser);
      if (update) {
        Get.back();
      }
    } else {
      Get.to(
        MaestroScreen(),
      );
    }
  }
}
