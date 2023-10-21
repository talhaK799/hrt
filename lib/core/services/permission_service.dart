import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
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