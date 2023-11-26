import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/splash_screen.dart';

import '../../../../core/constants/style.dart';

class AppSettingProvider extends BaseViewModel {
  bool isNotificationsOn = false;
  final auth = locator<AuthService>();
  final _db = DatabaseService();
  changeNotificaionSettin(val) async {
    isNotificationsOn = val;
    notifyListeners();
    auth.appUser.isNotificationsOn = val;
    await _db.updateUserProfile(auth.appUser);
  }

  terminateUser(context) async {
    //   setState(ViewState.busy);
    //   await auth.deleteUserAccount();
    //   Get.offAll(
    //     SplashScreen(),
    //   );
    //   setState(ViewState.idle);
    // }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Are you sure?',
              style: bodyTextStyle.copyWith(color: primaryColor),
            ),
            content: Text('Do you realy want to terminate your account'),
            actions: [
              TextButton(
                onPressed: () {
                  auth.deleteUserAccount();
                  notifyListeners();
                  Get.offAll(
                    SplashScreen(),
                  );
                },
                child: Text(
                  'YES',
                  style: buttonTextStyle2.copyWith(
                    color: lightRed,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'NO',
                  style: buttonTextStyle2.copyWith(
                    color: lightRed,
                  ),
                ),
              )
            ],
          );
        });
  }
}
