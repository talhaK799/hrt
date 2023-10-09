import 'package:flutter/material.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/likedUser.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeProvider extends BaseViewModel {
  int currentIndex = 0;
  bool isLiked = false;
  bool isRecent = false;
  bool isLast = false;
  final currentUser = locator<AuthService>().appUser;
  final db = DatabaseService();
  SfRangeValues ageValues = SfRangeValues(18, 30);
  SfRangeValues distanceValues = SfRangeValues(3, 50);
  final _db = DatabaseService();
  PageController? pageController;
  int index = 0;
  List<AppUser> users = [];
  LikedUser likedUser = LikedUser();

  HomeProvider() {
    getAllAppUsers();
    pageController = PageController(initialPage: 0);
    notifyListeners();
  }

  getAllAppUsers() async {
    setState(ViewState.busy);
    users = await _db.getAllUsers();
    print(' user id is : ${users.first.id}');
    setState(ViewState.idle);
  }

  updateIndex(index) {
    currentIndex = index;
    print('current index==> $index=====> $currentIndex');
    notifyListeners();
  }

  changePage(val) {
    index = val;
    if (val == users.indexOf(users.last) + 1) {
      isLast = true;
    } else {
      isLast = false;
    }
    // isLiked = false;
    notifyListeners();
  }

  like(index) async {
    likedUser.likignUsersIds = [];
    setState(ViewState.busy);
    users[index].isLiked = true;
    users[index].isDesLiked = false;
    likedUser.id = users[index].id;

    likedUser.likignUsersIds!.add(currentUser.id!);
    print('user  id ${currentUser.id}');
    if (!users[index].likedUsers!.contains(users[index].id)) {
      users[index].likedUsers!.add(users[index].id!);
      if (users[index].disLikedUsers!.contains(users[index].id)) {
        users[index].disLikedUsers!.remove(users[index].id!);
      }
    }
    bool isliked = await db.likeUser(likedUser);
    bool isUpdated = await db.updateUserProfile(users[index]);

    setState(ViewState.idle);
    if (isUpdated && isliked) {
      pageController!.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );

      notifyListeners();
    }
  }

  disLike(index) async {
    users[index].isDesLiked = true;
    users[index].isLiked = false;
    if (!users[index].disLikedUsers!.contains(users[index].id)) {
      users[index].disLikedUsers!.add(users[index].id!);
      if (users[index].likedUsers!.contains(users[index].id)) {
        users[index].likedUsers!.remove(users[index].id!);
      }
    }

    bool isUpdated = await db.updateUserProfile(users[index]);
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
