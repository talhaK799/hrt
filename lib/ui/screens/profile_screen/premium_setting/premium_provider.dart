import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class PremiumProvider extends BaseViewModel {
  final _auth = locator<AuthService>();
  final _db = DatabaseService();
  changePhotoesPrivacy(val) async {
    notifyListeners();
    _auth.appUser.isPrivatePhoto = val;
    await _db.updateUserProfile(_auth.appUser);
  }

}
