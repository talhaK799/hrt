import 'package:get/get.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends BaseViewModel {
  requestPermission() async {
    // final location = Permission.location;
    // final notification = Permission.notification;

    // if (await location.isDenied && await notification.isDenied) {
    //   await location.request();
    //   await notification.request();
    // } else {
    //   Get.snackbar('alert!', 'Permissions granted');
    Get.to(
      RootScreen(),
    );
    // }
    // if (await notification.isDenied) {
    //   await notification.request();
    // } else {
    //   Get.snackbar('alert!', 'notification permission granted');
    // }
  }
}
