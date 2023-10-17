import 'package:get/get.dart';
import 'package:hart/core/services/location_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class PermissionProvider extends BaseViewModel {
  final permissions = locator<LocationService>();
  getPermissions() async {
    await permissions.requestPermission();
    Get.to(
      RootScreen(),
    );
  }
}
