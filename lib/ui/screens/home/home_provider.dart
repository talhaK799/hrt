import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/models/filter.dart';
import 'package:hart/core/models/matches.dart';
import 'package:hart/core/models/report_user.dart';
import 'package:hart/core/models/uplift.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/custom_snackbar.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';
import 'package:hart/ui/screens/connection_screen/connect_popup/connect_popup_screen.dart';
import 'package:hart/ui/screens/profile_screen/kings_hart/king_hart_screen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../custom_widgets/dialogs/auth_dialog.dart';
import '../collect_info_screens/select_gender_screen/select_gender_screen.dart';
import 'country_city_picker.dart';

class HomeProvider extends BaseViewModel {
  int dotIndex = 0;
  bool isLiked = false;
  bool isDislike = false;
  // DateTime now = DateTime.now();

  bool isDisLiked = false;
  bool isRecent = false;
  bool isLast = false;
  bool isCurrent = false;
  final currentUser = locator<AuthService>();
  final location = locator<LocationService>();
  // final _localStorage = locator<LocalStorageService>();
  // Position? currentLocaion;
  final db = DatabaseService();
  // final _db = DatabaseService();
  PageController? pageController;
  int index = 0;
  // List<AppUser> users = [];
  List<AppUser> appUsers = [];
  List<AppUser> filteredUsers = [];
  List<Placemark> placemarks = [];
  List<String> lookingFor = ['Woman'];
  List<String> desire = ['Singles'];
  String country = '';
  String city = '';
  Matches match = Matches();
  Filtering filter = Filtering(desire: []);
  UPlift uPlift = UPlift();
  ReportedUser reportedUser = ReportedUser();

  bool isDataLoaded = false;

  HomeProvider() {
    // currentLocation.determinePosition();
    // appUsers = currentUser.appUsers;
    init();
    pageController = PageController(initialPage: 0);
  }

  init() async {
    if (currentUser.isHomeloaded == false) {
      print("make State busy for the first time");
      setState(ViewState.busy);
      currentUser.isHomeloaded = true;
    }

    await getAllAppUsers();
    appUsers = currentUser.appUsers;

    await convertLatAndLongIntoAddress();

    currentUser.appUser.onlineTime = DateTime.now();
    await db.updateUserProfile(currentUser.appUser);

    setState(ViewState.idle);
    notifyListeners();
  }

  checkUpliftedUser() async {
    uPlift = await db.checkUpliftUser(currentUser.appUser);
    DateTime now = DateTime.now();
    final difference = now.difference(uPlift.endAt ?? DateTime.now()).inHours;
    print("uplift difference ===> $difference");
    if (difference >= 0) {
      currentUser.appUser.isUplifted = false;
      await db.updateUserProfile(currentUser.appUser);
    }
  }

  convertLatAndLongIntoAddress() async {
    placemarks = [];
    placemarks = await placemarkFromCoordinates(
        location.currentLocation!.latitude,
        location.currentLocation!.longitude);
    // setState(ViewState.idle);

    country = placemarks.first.country!;
    city = placemarks.first.locality!;
    notifyListeners();
    print("country =>" + placemarks.first.country!);
    print("country =>" + placemarks.first.locality!);
  }

  getAllAppUsers() async {
// <<<<<<< text_changes
    try {
      print("all users: ${currentUser.appUsers.length}");
      appUsers = currentUser.appUsers;
      notifyListeners();
      if (currentUser.appUsers.isEmpty && currentUser.isHomeloaded == false) {
        // setState(ViewState.busy);
        await Future.delayed(Duration(seconds: 2));
        currentUser.isHomeloaded = true;
      }
      log('getting all AppUsers');
      // int dataLength = _localStorage.getdataLength;
      // print('data length===> $dataLength');
      // appUsers = [];
      currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
      currentUser.appUsers = await db.getAllUsers(currentUser.appUser);
      // setState(ViewState.idle);
      // if (users.length > dataLength) {
      //   await Future.delayed(Duration(seconds: 5));

      //   _localStorage.setdataLength = users.length;
      //   setState(ViewState.idle);
      // }
      log('number of all Appusers ${currentUser.appUsers.length}');
      await checkUpliftedUser();
      for (var user in currentUser.appUsers) {
        print('user ${user.id} onLineTime  ===> ${user.onlineTime.toString()}');
        // appUsers.add(user);
        // if (currentUser.appUser.likedUsers == null ||
        //     currentUser.appUser.disLikedUsers == null) {
// =======
//     try {
//       print("all users::: ${currentUser.appUsers.length}");

//       // int dataLength = _localStorage.getdataLength;
//       // print('data length===> $dataLength');
//       // appUsers = [];
//       currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
//       currentUser.appUsers = await db.getAllUsers(currentUser.appUser);
//       // if (users.length > dataLength) {
//       //   await Future.delayed(Duration(seconds: 5));

//       //   _localStorage.setdataLength = users.length;
//       //   setState(ViewState.idle);
//       // }
//       print('number of all Appusers ${currentUser.appUsers.length}');
//       await checkUpliftedUser();
//       for (var user in currentUser.appUsers) {
//         print('user ${user.id} onLineTime  ===> ${user.onlineTime.toString()}');
// >>>>>>> dev
        // appUsers.add(user);
        if (currentUser.appUser.likedUsers == null ||
            currentUser.appUser.disLikedUsers == null) {
          appUsers.add(user);
        } else {
          if (!currentUser.appUser.likedUsers!.contains(user.id) &&
              !currentUser.appUser.disLikedUsers!.contains(user.id) &&
              user.id != currentUser.appUser.id) {
            user.offlineTime =
                formatRelativeTime(user.onlineTime ?? DateTime.now()) ?? " ";
            user.distance = await location.distance(
                user.latitude,
                user.longitude,
                currentUser.appUser.latitude,
                currentUser.appUser.longitude);
            if (user.isUplifted == true) {
              log('id==> ${user.id} and uplifted==> ${user.isUplifted}');
              appUsers.insert(0, user);
            } else {
              log('id==> ${user.id} and uplifted==> ${user.isUplifted}');
              appUsers.add(user);
            }
          }
        }
        // }
      }

      print("AllUsers: ${appUsers.length}");

      currentUser.appUsers = appUsers;
      print('number of filtered users ${appUsers.length}');
    } catch (e) {
      print("@errorGetAllAppUsersHome: $e");
    }
  }

  reportUser(AppUser user) async {
    reportedUser.reportedUserId = user.id;
    reportedUser.reportingUserId = currentUser.appUser.id;
    reportedUser.reportedAt = DateTime.now();
    bool isreported = await db.reportUser(reportedUser);
    if (isreported == true) {
      Get.snackbar('Alert!', 'Profile Reported');
    }
  }

  spank(AppUser user, context) async {
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
      // Get.to(
      //   KingHartScreen(),
      // );
      Navigator.push(
        context,
        PageFromRight(
          page: KingHartScreen(),
        ),
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
  /// restore previous User
  ///
  restorePrevousProfile() async {
    if (currentUser.previousUsers.isEmpty) {
      customSnackBar('Alert!!', 'No previous profile');
    } else {
      appUsers.insert(0, currentUser.previousUsers.first);
      notifyListeners();
      print('appuser===> befor${currentUser.previousUsers.first.id}');

      /// romve the user form likes
      if (currentUser.appUser.likedUsers!
          .contains(currentUser.previousUsers.first.id)) {
        currentUser.appUser.likedUsers!
            .remove(currentUser.previousUsers.first.id);
      }

      /// romve the user form dislikes
      if (currentUser.appUser.disLikedUsers!
          .contains(currentUser.previousUsers.first.id)) {
        currentUser.appUser.disLikedUsers!
            .remove(currentUser.previousUsers.first.id);
      }
      currentUser.previousUsers.removeAt(0);
      await db.updateUserProfile(currentUser.appUser);

      // print('appuser===>after ${currentUser.previousUsers.first.id}');
    }
  }

  ///
  /// Like
  ///
  like(AppUser user, context) async {
    // print("User index ==> ${index}");
    // print('liked users ==> ${currentUser.appUser.likedUsers!.length}');
    print('user  id ${currentUser.appUser.id} liked ${user.id}');

    match.likedUserId = user.id;
    match.likedByUserId = currentUser.appUser.id;

    ///
    ///if currentUser likes other users
    ///
    if (await !currentUser.appUser.likedUsers!.contains(user.id)) {
      await Future.delayed(Duration(milliseconds: 400));
      // if (currentUser.appUser.likedUsers!.length <
      //     currentUser.appUser.likesCount!) {
      //////

      if (await !currentUser.previousUsers.contains(user)) {
        currentUser.previousUsers.add(user);
      }
      currentUser.appUser.likedUsers!.add(user.id!);
      // await pageController!.nextPage(
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeIn,
      // );

      ///
      /// if other user liked currentUser
      ///
      if (await user.likedUsers!.contains(currentUser.appUser.id)) {
        print('liked user id in user list ${user.likedUsers!.first}');
        match = await db.getRequest(
          user.id!,
          currentUser.appUser.id!,
        );

        appUsers.removeWhere((element) => element.id == user.id);
        notifyListeners();
        print(
            'match likedById ${match.likedByUserId}=== likedId ${match.likedUserId}');

        match.isAccepted = true;
        match.isProgressed = true;
        bool isReqUpdated = await db.updateRequest(match);
        if (isReqUpdated) {
          // Get.to(
          //   ConnectPopupScreen(),
          // );
          Navigator.push(
            context,
            PageFromRight(
              page: ConnectPopupScreen(),
            ),
          );
        } else {
          print('request faild ==> $isReqUpdated');
        }
      } else {
        appUsers.removeWhere((element) => element.id == user.id);
        notifyListeners();
        await db.addRequest(match);
      }

      // appUsers.removeWhere((element) => element.id == user.id);
      // notifyListeners();
      await db.updateUserProfile(currentUser.appUser);

      print('profile update ==> ${currentUser.appUser.likedUsers!.length}');
      // if (isUpdated) {

      // notifyListeners();
      if (appUsers.length > 0) {
        dotIndex = 0;
        // await pageController!.nextPage(
        //   duration: Duration(milliseconds: 300),
        //   curve: Curves.easeIn,
        // );
      }
      // }
      notifyListeners();

      print("Users ====> ${appUsers.first.name}");
      //////
      // } else {
      //   Get.to(
      //     MaestroScreen(),
      //   );
      // }
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
      // if (currentUser.appUser.disLikedUsers!.length <
      //     currentUser.appUser.likesCount!) {
      ////
      await Future.delayed(Duration(milliseconds: 500));
      if (await !currentUser.previousUsers.contains(user)) {
        print(
            'previous USERS list==> BEFORE ${currentUser.previousUsers.length}');
        currentUser.previousUsers.add(user);
        print(
            'previous USERS list==> AFTER ${currentUser.previousUsers.length}');
      }
      currentUser.appUser.disLikedUsers!.add(user.id!);

      appUsers.removeWhere((element) => element.id == user.id);
      notifyListeners();
      // notifyListeners();
      // pageController!.nextPage(
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeIn,
      // );
      // appUsers.remove(user);
      await db.updateUserProfile(currentUser.appUser);
      // if (isUpdated) {

      // pageController!.nextPage(
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeIn,
      // );
      // }

      //////
      // } else {
      //   Get.to(MaestroScreen());
      // }

      // notifyListeners();
    }
  }

  ///
  ///  filter
  ///

  selectGender(context) async {
    final list = await Navigator.push(
      context,
      PageFromRight(
        page: SelectGenderScreen(
          isFileter: true,
        ),
      ),
    );
    lookingFor = list ?? lookingFor;
    // Get.to(
    //       SelectGenderScreen(
    //         isFileter: true,
    //       ),
    //     ) ??
    //     lookingFor;
    notifyListeners();
  }

  selectDesire(context) async {
    final list = await Navigator.push(
      context,
      PageFromRight(
        page: FantasiesScreen(
          isFilter: true,
        ),
      ),
    );
    desire = list ?? desire;
    // Get.to(
    //       FantasiesScreen(
    //         isFilter: true,
    //       ),
    //     ) ??
    //     desire;
    filter.desire = desire;
    print(desire.length);
    notifyListeners();
  }

  selectCountry(context) async {
    List lis = [];
    lis = await Navigator.push(
      context,
      PageFromRight(
        page: CountrySelectionScren(),
      ),
    );
    print('list values ${lis[0]} and ${lis[1]}');
    country = lis[0];
    city = lis[1];
    notifyListeners();
  }

  recent(context, val) {
    if (currentUser.appUser.isPremiumUser == true) {
      isRecent = val;
    } else {
      becomeMaestroDialog(context, "This feature is only for Premium users");
      // customSnackBar('Alert!!', 'Allowed for Premium Users only');
    }
    notifyListeners();
  }

  current(val) {
    isCurrent = val;
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
    Get.back();
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
    // await getAllAppUsers();
    start = 18.0;
    end = 60.0;

    ageValues = SfRangeValues(18, 60);
    distanceValues = SfRangeValues(0, 50);
    isFiltering = false;
    filteredUsers = [];

    print(
        "filter===> ${filter.minAge} ${filter.lookingFor} ${filter.desire}  ");
// <<<<<<< HEAD
    filter = Filtering(
      desire: currentUser.appUser.desire,
      lookingFor: currentUser.appUser.lookingFor,
    );
// =======
//     filter = Filtering(desire: [filter.desire!.first]);
// >>>>>>> 5c30253d5dc233ad1f3b440b9bab2ed0e2f163f8
    notifyListeners();
    Get.back();
  }
}
