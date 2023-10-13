import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

import '../idetity_screen/identity_screen.dart';

class NickNameProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final db = DatabaseService();
  final formKey = GlobalKey<FormState>();

  addNickName() async {
    setState(ViewState.busy);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);
    setState(ViewState.idle);
    if (isUpdated) {
    Get.to(
      IdentityScreen(),
    );
    }
  }
}
