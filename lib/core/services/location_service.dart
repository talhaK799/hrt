import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }

    // if (permission == LocationPermission.deniedForever) {
    //   print(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  requestPermission() async {
    final location = Permission.location;
    final notification = Permission.notification;
    if (await location.isDenied || await notification.isDenied) {
      await location.request();
      await notification.request();
    } else {
      Get.snackbar('alert!', 'Permissions granted');
    }
    // if (await notification.isDenied) {
    //   await notification.request();
    // } else {
    //   Get.snackbar('alert!', 'notification permission granted');
    // }
  }
}
