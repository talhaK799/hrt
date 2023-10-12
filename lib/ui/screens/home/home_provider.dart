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
  final currentUser = locator<AuthService>();
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
    users = [];
    filteredUsers = [];
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    setState(ViewState.busy);
    users = await db.getAllUsers(currentUser.appUser);
    for (var user in users) {
      if (!currentUser.appUser.likedUsers!.contains(user.id) &&
          !currentUser.appUser.disLikedUsers!.contains(user.id)) {
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
    // index = val;
    // print(val);
    // if (val == filteredUsers.indexOf(filteredUsers.last) + 1) {
    //   isLast = true;
    // } else {
    //   isLast = false;
    // }
    // isLiked = false;
    notifyListeners();
  }

  ///
  /// Like
  ///
  like(AppUser user) async {
    print("User index ==> ${index}");
    print('liked users ==> ${currentUser.appUser.likedUsers!.length}');
    print('user  id ${currentUser.appUser.id} liked ${user.id}');

    if (await !currentUser.appUser.likedUsers!.contains(user.id)) {
      currentUser.appUser.likedUsers!.add(user.id!);
      // if (await currentUser.disLikedUsers!.contains(user.id)) {
      //   currentUser.disLikedUsers!.remove(user.id!);
      // }
    }

    matches.likedUserId = user.id;
    matches.likedByUserId = currentUser.appUser.id;
    bool isRequested = await db.addRequest(matches);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);

    print('profile update ==> ${currentUser.appUser.likedUsers!.length}');
    if (isUpdated && isRequested) {
      filteredUsers.removeWhere((element) => element.id == user.id);

      notifyListeners();
      if (filteredUsers.length > 0) {
        dotIndex = 0;
        await pageController!.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    }
    notifyListeners();

    print("Users ====> ${filteredUsers.length}");
  }

  ///
  /// DisLike
  ///
  disLike(AppUser user) async {
    if (await !currentUser.appUser.disLikedUsers!.contains(user.id)) {
      currentUser.appUser.disLikedUsers!.add(user.id!);
      if (await currentUser.appUser.likedUsers!.contains(user.id)) {
        currentUser.appUser.likedUsers!.remove(user.id!);
      }
    }

    bool isUpdated = await db.updateUserProfile(currentUser.appUser);
    if (isUpdated) {
      filteredUsers.removeWhere((element) => element.id == user.id);
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
