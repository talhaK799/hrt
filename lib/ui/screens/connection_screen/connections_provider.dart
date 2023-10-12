import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

import '../../../core/services/database_service.dart';

class ConnectionsProvider extends BaseViewModel {
  bool isLiked = false;
  bool disLiked = false;

  final db = DatabaseService();
  final currentUser = locator<AuthService>().appUser;
  AppUser user = AppUser();
  List<Matches> matches = [];
  // Matches match = Matches();
  List<AppUser> likingUsers = [];
  ConnectionsProvider() {
    getLikingUsers();
  }

  getLikingUsers() async {
    setState(ViewState.busy);
    matches = await db.getAllRequest(currentUser.id!);
    for (var m in matches) {
      user = await db.getAppUser(m.likedByUserId);
      likingUsers.add(user);
    }
    setState(ViewState.idle);
  }

  like(AppUser user, Matches match) async {
    print('user  id ${currentUser.id} liked ${user.id}');
    if (await !currentUser.likedUsers!.contains(user.id)) {
      currentUser.likedUsers!.add(user.id!);
      if (await currentUser.disLikedUsers!.contains(user.id)) {
        currentUser.disLikedUsers!.remove(user.id!);
      }
    }

    match.isAccepted = true;
    match.isRejected = false;
    match.isProgressed = true;
    bool isUpdatedMatch = await db.updateRequest(match);
    bool isUpdated = await db.updateUserProfile(currentUser);

    print('profile update ==> ${isUpdated} requestUpdate==>${isUpdatedMatch}');
    if (isUpdated && isUpdatedMatch) {
      likingUsers.remove(user);
    }
    notifyListeners();
  }

  dilike(AppUser user, Matches match) async {
    print('user  id ${currentUser.id} disliked ${user.id}');
    if (await !currentUser.disLikedUsers!.contains(user.id)) {
      currentUser.disLikedUsers!.add(user.id!);
      if (await currentUser.likedUsers!.contains(user.id)) {
        currentUser.likedUsers!.remove(user.id!);
      }
    }

    match.isRejected = true;
    match.isAccepted = false;
    match.isProgressed = true;
    bool isUpdatedMatch = await db.updateRequest(match);
    bool isUpdated = await db.updateUserProfile(currentUser);

    print('profile update ==> ${isUpdated} requestUpdate==>${isUpdatedMatch}');
    if (isUpdated && isUpdatedMatch) {
      likingUsers.remove(user);
    }
    notifyListeners();
  }
}
