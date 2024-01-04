import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/connection_screen/connect_popup/connect_popup_screen.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';
import '../../../core/services/database_service.dart';

class ConnectionsProvider extends BaseViewModel {
  bool isLiked = false;
  bool disLiked = false;

  final db = DatabaseService();
  final currentUser = locator<AuthService>();
  AppUser user = AppUser();
  // Matches match = Matches();
  // List<AppUser> likingUsers = [];
  ConnectionsProvider() {
    getLikingUsers();
    currentUser.appUser.onlineTime = DateTime.now();
    db.updateUserProfile(currentUser.appUser);
  }

  getLikingUsers() async {
    if (currentUser.matches.isEmpty &&
        currentUser.isConnectionloaded == false) {
      setState(ViewState.busy);
      await Future.delayed(Duration(seconds: 2));
      currentUser.isConnectionloaded = true;
    }
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    currentUser.matches = await db.getAllRequest(currentUser.appUser.id!);
    setState(ViewState.idle);

    if (currentUser.likingUsers.length < currentUser.matches.length) {
      currentUser.likingUsers = [];
      for (var m in currentUser.matches) {
        user = await db.getAppUser(m.likedByUserId);
        currentUser.likingUsers.add(user);
      }
    }
    notifyListeners();
  }

  like(AppUser user, Matches match, context) async {
    print('user  id ${currentUser.appUser.id} liked ${user.id}');
    if (await !currentUser.appUser.likedUsers!.contains(user.id)) {
      if (currentUser.appUser.likedUsers!.length <=
          (currentUser.appUser.likesCount ?? 0)) {
        currentUser.appUser.likedUsers!.add(user.id!);
        match.isAccepted = true;
        match.isRejected = false;
        match.isProgressed = true;
        bool isUpdatedMatch = await db.updateRequest(match);
        bool isUpdated = await db.updateUserProfile(currentUser.appUser);

        print(
            'profile update ==> ${isUpdated} requestUpdate==>${isUpdatedMatch}');
        if (isUpdated && isUpdatedMatch) {
          currentUser.likingUsers.remove(user);
          // Get.to(
          //   ConnectPopupScreen(),
          // );
          Navigator.push(
            context,
            PageFromRight(
              page: ConnectPopupScreen(),
            ),
          );
        }
        notifyListeners();
      } else {
        // Get.to(
        //   MaestroScreen(),
        // );
        Navigator.push(
          context,
          PageFromRight(
            page: MaestroScreen(),
          ),
        );
      }
    }

    // if (await user.likedUsers!.contains(currentUser.appUser.id)) {

    // }
  }

  dilike(AppUser user, Matches match) async {
    print('user  id ${currentUser.appUser.id} disliked ${user.id}');
    if (await !currentUser.appUser.disLikedUsers!.contains(user.id)) {
      // if (currentUser.appUser.likedUsers!.length <=
      //     currentUser.appUser.likesCount!) {
      currentUser.appUser.disLikedUsers!.add(user.id!);
      match.isRejected = true;
      match.isAccepted = false;
      match.isProgressed = true;
      bool isUpdatedMatch = await db.updateRequest(match);
      bool isUpdated = await db.updateUserProfile(currentUser.appUser);

      print(
          'profile update ==> ${isUpdated} requestUpdate==>${isUpdatedMatch}');
      if (isUpdated && isUpdatedMatch) {
        currentUser.likingUsers.remove(user);
      }
      notifyListeners();
      // } else {
      //   Get.to(
      //     MaestroScreen(),
      //   );
      // }
    }
  }
}
