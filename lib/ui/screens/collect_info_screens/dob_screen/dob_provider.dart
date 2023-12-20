import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/nick_name/nick_name_screen.dart';

class DobProvider extends BaseViewModel {
  DateTime? pickedDate;
  DateTime? now = DateTime.now();
  final currentUser = locator<AuthService>();
  final DatabaseService db = DatabaseService();
  String dob = '';
  int age = 0;
  bool updation = false;

  DobProvider(isUpdation) {
    print('udate prof  $isUpdation');
    updation = isUpdation;
    notifyListeners();
  }

  pickDate(context) async {
    pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1971),
      lastDate: DateTime(2090),
      dateFormat: "dd/MM/yyyy",
      looping: true,
      backgroundColor: whiteColor,
      itemTextStyle: bodyTextStyle,
      textColor: primaryColor,
    );
    if (pickedDate != null) {
      dob = date.format(pickedDate!);
    } else {
      Get.snackbar(
        'Alert!!',
        '',
        colorText: primaryColor,
        messageText: Text(
          'Age must be Selected first',
          style: miniText.copyWith(
            color: lightRed,
            fontSize: 15.sp,
          ),
        ),
      );
    }
    notifyListeners();
  }

  addDob() async {
    age = now!.year - pickedDate!.year;

    if (age >= 18) {
      // setState(ViewState.busy);
      currentUser.appUser.dob = dob;
      currentUser.appUser.age = age;
      // bool isProfUpdated = await db.updateUserProfile(currentUser.appUser);
      // if (isProfUpdated) {
      print('updatrion==> $updation');
      if (updation) {
        Get.back(result: dob);
      } else {
        Get.to(
          NickNameScreen(),
        );
      }
      // }
      // setState(ViewState.idle);
    } else {
      Get.snackbar(
        'Alert!!',
        'Age must be 18 or above',
        colorText: primaryColor,
        messageText: Text(
          'Age must be 18 or above',
          style: miniText.copyWith(
            color: lightRed,
            fontSize: 15.sp,
          ),
        ),
      );
    }

    print('this is the age $age');

    notifyListeners();
  }
}
