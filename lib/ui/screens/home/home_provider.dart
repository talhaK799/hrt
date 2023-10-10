import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeProvider extends BaseViewModel {
  int dotIndex = 0;
  bool isLiked = false;
  bool isDisLiked = false;
  bool isRecent = false;
  bool isLast = false;
  final currentUser = locator<AuthService>().appUser;
  final db = DatabaseService();
  SfRangeValues ageValues = SfRangeValues(18, 30);
  SfRangeValues distanceValues = SfRangeValues(3, 50);
  // final _db = DatabaseService();
  PageController? pageController;
  int index = 0;
  List<AppUser> users = [];
  List<AppUser> filteredUsers = [];
  Matches matches = Matches();

  HomeProvider() {
    init();
    pageController = PageController(initialPage: 0);
    notifyListeners();
  }
  init() async {
    await getAllAppUsers();
  }

  getAllAppUsers() async {
    setState(ViewState.busy);
    users = await db.getAllUsers(currentUser);
    for (var user in users) {
      if (!currentUser.likedUsers!.contains(user.id) &&
          !currentUser.likedUsers!.contains(user.id)) {
        filteredUsers.add(user);
        notifyListeners();
      }
    }
    setState(ViewState.idle);
  }

  updateIndex(index) {
    dotIndex = index;
    print('current index==> $index=====> $dotIndex');
    notifyListeners();
  }

  changePage(val) {
    dotIndex = 0;
    index = val;
    if (val == users.indexOf(users.last) + 1) {
      isLast = true;
    } else {
      isLast = false;
    }
    // isLiked = false;
    notifyListeners();
  }

  ///
  /// Like
  ///
  like(AppUser user) async {
    print('user  id ${currentUser.id} liked ${user.id}');
    if (await !currentUser.likedUsers!.contains(user.id)) {
      currentUser.likedUsers!.add(user.id!);
      if (await currentUser.disLikedUsers!.contains(user.id)) {
        currentUser.disLikedUsers!.remove(user.id!);
      }
    }
    matches.likedUserId = user.id;
    matches.likedByUserId = currentUser.id;
    bool isRequested = await db.addRequest(matches);
    bool isUpdated = await db.updateUserProfile(currentUser);

    print('profile update ==> ${isUpdated}');
    if (isUpdated && isRequested) {
      pageController!.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      filteredUsers.remove(user);
    }
    notifyListeners();
  }

  ///
  /// DisLike
  ///
  disLike(AppUser user) async {
    if (await !currentUser.disLikedUsers!.contains(user.id)) {
      currentUser.disLikedUsers!.add(user.id!);
      if (await currentUser.likedUsers!.contains(user.id)) {
        currentUser.likedUsers!.remove(user.id!);
      }
    }

    bool isUpdated = await db.updateUserProfile(currentUser);
    if (isUpdated) {
      pageController!.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }

    notifyListeners();
  }

  recent(val) {
    isRecent = val;
    notifyListeners();
  }

  selectAge(values) {
    ageValues = values;
    notifyListeners();
  }

  selectDistance(values) {
    distanceValues = values;
    notifyListeners();
  }
}
