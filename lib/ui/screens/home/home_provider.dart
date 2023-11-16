import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/filter.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';
import 'package:hart/ui/screens/connection_screen/connect_popup/connect_popup_screen.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_screen.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../collect_info_screens/select_gender_screen/select_gender_screen.dart';

class HomeProvider extends BaseViewModel {
  int dotIndex = 0;
  bool isLiked = false;
  bool isDislike = false;

  bool isDisLiked = false;
  bool isRecent = false;
  bool isLast = false;
  final currentUser = locator<AuthService>();
  final currentLocaion = locator<LocationService>().currentLocation;
  // Position? currentLocaion;
  final db = DatabaseService();
  // final _db = DatabaseService();
  PageController? pageController;
  int index = 0;
  List<AppUser> users = [];
  List<AppUser> appUsers = [];
  List<AppUser> filteredUsers = [];
  List<Placemark> placemarks = [];
  String lookingFor = 'Woman';
  String desire = 'Singles';
  String country = '';
  Matches match = Matches();
  Filtering filter = Filtering();
  bool isDataLoaded = false;

  HomeProvider() {
    // currentLocation.determinePosition();

    init();
    // gender = lookingFor.first;
    // desire = desires.first;
    pageController = PageController(initialPage: 0);
  }
  init() async {
    setState(ViewState.busy);
    await getAllAppUsers();

    convertLatAndLongIntoAddress();

    setState(ViewState.idle);
    notifyListeners();
  }

  convertLatAndLongIntoAddress() async {
    placemarks = [];
    setState(ViewState.busy);
    placemarks = await placemarkFromCoordinates(
        currentLocaion!.latitude, currentLocaion!.longitude);
    setState(ViewState.idle);

    country = placemarks.first.country!;
    notifyListeners();
    print("country =>" + placemarks.first.country!);
  }

  getAllAppUsers() async {
    print('getting all AppUsers');
    users = [];
    appUsers = [];
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    setState(ViewState.busy);
    users = await db.getAllUsers(currentUser.appUser);

    print('number of all Appusers ${users.length}');

    await Future.delayed(Duration(seconds: 5));
    setState(ViewState.idle);

    for (var user in users) {
      // appUsers.add(user);
      if (currentUser.appUser.likedUsers == null ||
          currentUser.appUser.disLikedUsers == null) {
        appUsers.add(user);
      } else {
        if (!currentUser.appUser.likedUsers!.contains(user.id) &&
            !currentUser.appUser.disLikedUsers!.contains(user.id)) {
          appUsers.add(user);
          notifyListeners();
        }
      }
    }
    print('number of filtered users ${appUsers.length}');
    notifyListeners();
    // setState(ViewState.idle);
  }

  spank(AppUser user) async {
    if (currentUser.appUser.spanks != 0) {
      currentUser.appUser.spanks = currentUser.appUser.spanks! - 1;
      notifyListeners();
      if (!currentUser.appUser.likedUsers!.contains(user.id)) {
        currentUser.appUser.likedUsers!.add(user.id!);
        await db.updateUserProfile(currentUser.appUser);
      }
      if (!user.likedUsers!.contains(currentUser.appUser.id!)) {
        user.likedUsers!.add(currentUser.appUser.id!);
        await db.updateUserProfile(user);
      }

      appUsers.removeWhere((element) => element.id == user.id);

      // notifyListeners();
      if (appUsers.length > 0) {
        dotIndex = 0;
        await pageController!.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
      notifyListeners();
    } else {
      Get.to(
        KingHartScreen(),
      );
    }
  }

  updateIndex(index) {
    dotIndex = index;
    print('current index==> $index=====> $dotIndex');
    notifyListeners();
  }

  changePage(val) {
    dotIndex = 0;
    notifyListeners();
  }

  ///
  /// Like
  ///
  like(AppUser user) async {
    // print("User index ==> ${index}");
    // print('liked users ==> ${currentUser.appUser.likedUsers!.length}');
    print('user  id ${currentUser.appUser.id} liked ${user.id}');

    match.likedUserId = user.id;
    match.likedByUserId = currentUser.appUser.id;

    ///
    ///if currentUser likes other users
    ///
    if (await !currentUser.appUser.likedUsers!.contains(user.id)) {
      if (currentUser.appUser.likedUsers!.length <
          currentUser.appUser.likesCount!) {
        currentUser.appUser.likedUsers!.add(user.id!);

        ///
        /// if other user liked currentUser
        ///
        if (await user.likedUsers!.contains(currentUser.appUser.id)) {
          print('liked user id in user list ${user.likedUsers!.first}');
          match = await db.getRequest(
            user.id!,
            currentUser.appUser.id!,
          );
          print(
              'match likedById ${match.likedByUserId}=== likedId ${match.likedUserId}');

          match.isAccepted = true;
          match.isProgressed = true;
          bool isReqUpdated = await db.updateRequest(match);
          if (isReqUpdated) {
            Get.to(
              ConnectPopupScreen(),
            );
          } else {
            print('request faild ==> $isReqUpdated');
          }
        } else {
          await db.addRequest(match);
        }

        bool isUpdated = await db.updateUserProfile(currentUser.appUser);

        print('profile update ==> ${currentUser.appUser.likedUsers!.length}');
        if (isUpdated) {
          appUsers.removeWhere((element) => element.id == user.id);

          notifyListeners();
          if (appUsers.length > 0) {
            dotIndex = 0;
            await pageController!.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        }
        notifyListeners();

        print("Users ====> ${appUsers.first.name}");
      } else {
        Get.to(
          MaestroScreen(),
        );
      }
      isLiked = false;
      isDislike = false;
    }

    notifyListeners();
  }

  ///
  /// DisLike
  ///
  disLike(AppUser user) async {
    if (await !currentUser.appUser.disLikedUsers!.contains(user.id)) {
      if (currentUser.appUser.disLikedUsers!.length <
          currentUser.appUser.likesCount!) {
        currentUser.appUser.disLikedUsers!.add(user.id!);
        print(
            'likes count== ${currentUser.appUser.likesCount} and length==> ${currentUser.appUser.disLikedUsers!.length}');
        bool isUpdated = await db.updateUserProfile(currentUser.appUser);
        if (isUpdated) {
          appUsers.removeWhere((element) => element.id == user.id);
          pageController!.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }

        notifyListeners();
      } else {
        Get.to(MaestroScreen());
      }
    }
  }

  ///
  ///  filter
  ///

  selectGender() async {
    lookingFor = await Get.to(
          SelectGenderScreen(
            isFileter: true,
          ),
        ) ??
        lookingFor;
    notifyListeners();
  }

  selectDesire() async {
    desire = await Get.to(
          FantasiesScreen(
            isFilter: true,
          ),
        ) ??
        desire;
    notifyListeners();
  }

  selectCountry(val) {
    country = val;
    notifyListeners();
  }

  recent(val) {
    isRecent = val;
    notifyListeners();
  }

  selectAge(values) {
    ageValues = SfRangeValues(values.start, values.end);
    notifyListeners();
  }

  selectDistance(values) {
    distanceValues = SfRangeValues(0, values.end);
    notifyListeners();
  }

  /// ================================================= ///
  /// ================ Filter ========================= ///
  /// ================================================= ///
  ///

  SfRangeValues ageValues = SfRangeValues(18, 30);
  SfRangeValues distanceValues = SfRangeValues(0, 70);
  double start = 1.0;
  double end = 1.0;
  bool isFiltering = false;

  applyAge(SfRangeValues changedValue) {
    ageValues = changedValue;
    start = changedValue.start;
    end = changedValue.end;
    filter.maxAge = end.toInt();
    filter.minAge = start.toInt();

    notifyListeners();
  }

  applyFilter() async {
    // searchedCards = [];
    filter.lookingFor = lookingFor;
    filter.desire = desire;
    filteredUsers = [];
    isFiltering = true;
    print(
        "filter===> ${filter.minAge} ${filter.lookingFor} ${filter.desire}  ");
    notifyListeners();
    filteredUsers = appUsers
        .where((user) => (user.age! <= filter.maxAge! &&
                user.age! >= filter.minAge! &&
                user.desire!.contains(desire) &&
                user.lookingFor!.contains(lookingFor)
            ? true
            : false))
        .toList();

    print('filtered User===> ${filteredUsers.first.name}');
    notifyListeners();

    Get.back();
  }

  resetFilter() async {
    await getAllAppUsers();
    start = 18.0;
    end = 60.0;

    ageValues = SfRangeValues(18, 60);
    isFiltering = false;
    filteredUsers = [];

    print(
        "filter===> ${filter.minAge} ${filter.lookingFor} ${filter.desire}  ");
    filter = Filtering();
    notifyListeners();
    Get.back();
  }
}
