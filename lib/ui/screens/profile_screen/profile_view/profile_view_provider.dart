import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class ProfileViewProvider extends BaseViewModel {
  final _auth = locator<AuthService>();
  AppUser currentUser = AppUser();
  int dotIndex = 0;
  ProfileViewProvider() {
    currentUser = _auth.appUser;
  }

  updateIndex(index) {
    dotIndex = index;
    notifyListeners();
  }
}
