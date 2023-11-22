import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/others/dynamic_link_handler.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/splash_screen.dart';
import 'package:share_plus/share_plus.dart';

class ProfileProvider extends BaseViewModel {
  final _auth = locator<AuthService>();
  AppUser currentUser = AppUser();
  final db = locator<DatabaseService>();
  String? country;
  List<Placemark> placemark = [];

  final currentLocation = locator<LocationService>().currentLocation;

  ProfileProvider() {
    print(
        'current location ==> ${currentLocation!.latitude} X ${currentLocation!.longitude}');
    currentUser = _auth.appUser;
    init();
  }

  init() async {
    setState(ViewState.busy);
    currentUser = await db.getAppUser(_auth.appUser.id);
    await convertLatAndLongIntoAddress();
    setState(ViewState.idle);
  }

  convertLatAndLongIntoAddress() async {
    placemark = [];
    setState(ViewState.busy);
    placemark = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    setState(ViewState.idle);
    country = placemark.first.country;
    notifyListeners();
    print("country =>" + country!);
  }

  final auth = locator<AuthService>();
  final linkHandler = locator<DynamicLinkHandler>();

  PairProfilePorvider() {
    linkHandler.initDeepLinks();
  }

  shareLink() async {
    await linkHandler.createLink(auth.appUser.id!).then((value) {
      Share.share(
        'Join me on Feeld as my partner. You need to be logged in and tap on this link to accept the invite $value',
      );
    });

    notifyListeners();
  }

  logout() async {
    setState(ViewState.busy);
    await _auth.logout(_auth.appUser.id);
    Get.offAll(
      SplashScreen(),
    );
    setState(ViewState.idle);
  }
}
