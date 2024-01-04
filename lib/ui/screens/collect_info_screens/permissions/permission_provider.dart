import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/services/permission_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class PermissionProvider extends BaseViewModel {
  final permissions = locator<PermissionsService>();
  getPermissions(context) async {
    await permissions.requestPermission();
    // Get.to(
    //   RootScreen(),
    // );
    Navigator.push(
      context,
      PageFromRight(
        page: RootScreen(),
      ),
    );
  }
}
