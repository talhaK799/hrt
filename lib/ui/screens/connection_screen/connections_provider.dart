import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/connection_screen/connect_popup/connect_popup_screen.dart';

import '../../../core/services/database_service.dart';

class ConnectionsProvider extends BaseViewModel {
  bool isLiked = false;
  bool disLiked = false;

  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  AppUser user = AppUser();
  List<Matches> matches = [];
  // Matches match = Matches();
  List<AppUser> likingUsers = [];
  ConnectionsProvider() {
    getLikingUsers();
  }

  getLikingUsers() async {
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    setState(ViewState.busy);
    matches = await db.getAllRequest(currentUser.appUser.id!);
    for (var m in matches) {
      user = await db.getAppUser(m.likedByUserId);
      likingUsers.add(user);
    }
    setState(ViewState.idle);
  }

  like(AppUser user, Matches match) async {
    print('user  id ${currentUser.appUser.id} liked ${user.id}');
    if (await !currentUser.appUser.likedUsers!.contains(user.id)) {
      currentUser.appUser.likedUsers!.add(user.id!);
    }

    // if (await user.likedUsers!.contains(currentUser.appUser.id)) {

    // }

    match.isAccepted = true;
    match.isRejected = false;
    match.isProgressed = true;
    bool isUpdatedMatch = await db.updateRequest(match);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);

    print('profile update ==> ${isUpdated} requestUpdate==>${isUpdatedMatch}');
    if (isUpdated && isUpdatedMatch) {
      likingUsers.remove(user);
      Get.to(
        ConnectPopupScreen(),
      );
    }
    notifyListeners();
  }

  dilike(AppUser user, Matches match) async {
    print('user  id ${currentUser.appUser.id} disliked ${user.id}');
    if (await !currentUser.appUser.disLikedUsers!.contains(user.id)) {
      currentUser.appUser.disLikedUsers!.add(user.id!);
      if (await currentUser.appUser.likedUsers!.contains(user.id)) {
        currentUser.appUser.likedUsers!.remove(user.id!);
      }
    }

    match.isRejected = true;
    match.isAccepted = false;
    match.isProgressed = true;
    bool isUpdatedMatch = await db.updateRequest(match);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);

    print('profile update ==> ${isUpdated} requestUpdate==>${isUpdatedMatch}');
    if (isUpdated && isUpdatedMatch) {
      likingUsers.remove(user);
    }
    notifyListeners();
  }
}
