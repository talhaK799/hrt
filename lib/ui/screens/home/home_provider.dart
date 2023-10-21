import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
import 'package:hart/ui/screens/connection_screen/connect_popup/connect_popup_screen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeProvider extends BaseViewModel {
  int dotIndex = 0;
  bool isLiked = false;
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
  String? gender;
  String? desire;
  String? country;
  Matches match = Matches();
  Filtering filter = Filtering();

  HomeProvider() {
    // currentLocation.determinePosition();

    init();
    gender = lookingFor.first;
    desire = desires.first;
    pageController = PageController(initialPage: 0);
    notifyListeners();
  }
  init() async {
    await getAllAppUsers();

    convertLatAndLongIntoAddress();
  }

  convertLatAndLongIntoAddress() async {
    placemarks = [];
    setState(ViewState.busy);
    placemarks = await placemarkFromCoordinates(
        currentLocaion!.latitude, currentLocaion!.longitude);
    setState(ViewState.idle);
    countries.insert(0, placemarks.first.country!);

    country = countries.first;
    notifyListeners();
    print("country =>" + placemarks.first.country!);
  }

  getAllAppUsers() async {
    users = [];
    appUsers = [];
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    setState(ViewState.busy);
    users = await db.getAllUsers(currentUser.appUser);
    for (var user in users) {
      if (!currentUser.appUser.likedUsers!.contains(user.id) &&
          !currentUser.appUser.disLikedUsers!.contains(user.id)) {
        appUsers.add(user);
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
      currentUser.appUser.likedUsers!.add(user.id!);

      ///
      /// if other user likes currentUser
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
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }
      notifyListeners();

      print("Users ====> ${appUsers.length}");
    }
  }

  ///
  /// DisLike
  ///
  disLike(AppUser user) async {
    if (await !currentUser.appUser.disLikedUsers!.contains(user.id)) {
      currentUser.appUser.disLikedUsers!.add(user.id!);
    }

    bool isUpdated = await db.updateUserProfile(currentUser.appUser);
    if (isUpdated) {
      appUsers.removeWhere((element) => element.id == user.id);
      pageController!.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }

    notifyListeners();
  }

  List<String> lookingFor = [
    'Women',
    'Men',
    'Boys',
    'Girs',
  ];
  List<String> desires = [
    'Any',
    'Friendship',
    'Marriage',
  ];
  List<String> countries = [
    'Pakistan',
    'India',
    'Afghanistan',
  ];

  selectGender(val) {
    gender = val;
    notifyListeners();
  }

  selectDesire(val) {
    desire = val;
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
    ageValues = SfRangeValues(18, values.end);
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

  applyFilter() {
    // searchedCards = [];
    filteredUsers = [];
    isFiltering = true;
    notifyListeners();
    filteredUsers = appUsers
        .where((user) =>
            (user.age! <= filter.maxAge! && user.age! >= filter.minAge!
                ? true
                : false))
        .toList();
    notifyListeners();

    // if (searchedUsers.isNotEmpty) {
    //   for (var i = 0; i < searchedUsers.length; i++) {
    //     searchedCards.add(CustomSwappingCard(user: searchedUsers[i]));
    //   }
    // }
    // this.index = searchedUsers.length;
    // print("Searched user ==> ${searchedUsers.length}");
    Get.back();
  }

  resetFilter() async {
    await getAllAppUsers();
    start = 18.0;
    end = 60.0;

    ageValues = SfRangeValues(18, 60);
    isFiltering = false;
    filteredUsers = [];

    filter = Filtering();
    notifyListeners();
    Get.back();
  }
}
