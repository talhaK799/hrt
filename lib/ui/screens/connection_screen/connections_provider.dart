import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class ConnectionsProvider extends BaseViewModel {
  bool isLiked = true;
  final currenUser = locator<AuthService>().appUser;
  List<String> likingUsersIds = [];
  List<AppUser> likingUsers = [];

  getLikingUsrs() async {
    likingUsersIds = currenUser.likedUsers!;
  }
}
