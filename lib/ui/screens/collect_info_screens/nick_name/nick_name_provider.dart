import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';

import '../idetity_screen/identity_screen.dart';

class NickNameProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final db = DatabaseService();
  final formKey = GlobalKey<FormState>();
  String nickName = '';
  bool isprof = false;

  NickNameProvider(isProfUpdt) {
    isprof = isProfUpdt;
  }

  addNickName(context) async {
    currentUser.appUser.nickName = nickName;
    // setState(ViewState.busy);
    // bool isUpdated = await db.updateUserProfile(currentUser.appUser);
    // setState(ViewState.idle);
    // if (isUpdated) {
    isprof == true
        ? 
        // Get.back(result: nickName)
        Navigator.pop(context,nickName)
        : Navigator.push(
            context,
            PageFromRight(
              page: IdentityScreen(),
            ),
          );
    // Get.to(
    //     IdentityScreen(),
    //   );
    // }
  }
}
