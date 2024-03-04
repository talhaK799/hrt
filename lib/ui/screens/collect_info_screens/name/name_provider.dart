import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';

import '../idetity_screen/identity_screen.dart';

class NameProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final db = DatabaseService();
  final formKey = GlobalKey<FormState>();
  String name = '';
  bool isprof = false;

  NameProvider(isProfUpdt) {
    isprof = isProfUpdt;
  }

  addName(context) async {
    currentUser.appUser.name = name;
    setState(ViewState.busy);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);
    setState(ViewState.idle);
    if (isUpdated) {
      Navigator.pop(context, name);
    }
  }
}
