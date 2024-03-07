import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class AboutProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final db = DatabaseService();
  final formKey = GlobalKey<FormState>();
  String about = '';
  bool isprof = false;

  AboutProvider(isProfUpdt) {
    isprof = isProfUpdt;
  }

  saveAbout(context) async {
    currentUser.appUser.about = about;
    setState(ViewState.busy);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);
    setState(ViewState.idle);
    if (isUpdated) {
      if (isprof == true) {
        Navigator.pop(context, about);
      } else {
        Get.offAll(RootScreen());
      }
    }
  }
}
