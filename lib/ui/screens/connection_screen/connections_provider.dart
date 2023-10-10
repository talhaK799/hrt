import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

import '../../../core/services/database_service.dart';

class ConnectionsProvider extends BaseViewModel {
  bool isLiked = true;

  final db = DatabaseService();
  final currenUser = locator<AuthService>().appUser;
  AppUser user = AppUser();
  List<Matches> matches = [];
  List<AppUser> appusers = [];
  ConnectionsProvider() {
    getLikingUsers();
  }

  getLikingUsers() async {
    setState(ViewState.busy);
    matches = await db.getAllRequest(currenUser.id!);
    for (var m in matches) {
      user = await db.getAppUser(m.likedByUserId);
      appusers.add(user);
    }
    setState(ViewState.idle);
  }
}
