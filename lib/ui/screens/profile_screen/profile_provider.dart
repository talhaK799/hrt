import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/app_user.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/splash_screen.dart';

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
    print("country =>" + placemark.first.country!);
  }

  logout() async {
    setState(ViewState.busy);
    await _auth.logout();
    Get.offAll(
      SplashScreen(),
    );
    setState(ViewState.idle);
  }
}
