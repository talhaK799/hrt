import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/idetity_screen/identity_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_screen.dart';

import '../../collect_info_screens/nick_name/nick_name_screen.dart';

class EditProfileProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseService();
  bool isIncoginito = false;
  DateTime? pickedDate;
  List<String> interst = [];
  String desire = '';

  // DateTime? dob;

  EditProfileProvider() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
    print('looking for ${currentUser.appUser.lookingFor!.first}');
    // dob = date.parse(currentUser.appUser.dob!);
    setState(ViewState.idle);
  }

  pickDate(context) async {
    pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1971),
      lastDate: DateTime(2090),
      dateFormat: "dd/MM/yyyy",
      looping: true,
    );
    notifyListeners();
  }

  updateProfile() async {
    currentUser.appUser.dob = pickedDate.toString();
    currentUser.appUser.desire!.add(desire);
    currentUser.appUser.lookingFor = interst;
    setState(ViewState.busy);
    bool isUpdated = await db.updateUserProfile(currentUser.appUser);

    setState(ViewState.idle);
    if (isUpdated) {
      Get.snackbar('success', 'profile updated');
    } else {
      Get.snackbar('error!', 'Unable to update profile');
    }
  }

  incognito(val) {
    if (currentUser.appUser.isPremiumUser == true) {
      isIncoginito = val;
    } else {
      Get.snackbar('message', 'Become a Maestro', colorText: whiteColor);
    }

    notifyListeners();
  }

  changeNickName() async {
    currentUser.appUser.nickName = await Get.to(
          NickNameScreen(
            isUpdate: true,
          ),
        ) ??
        currentUser.appUser.nickName;
    notifyListeners();
  }

  changeDob() async {
    currentUser.appUser.dob = await Get.to(
          DOBScreen(
            isUpdate: true,
          ),
        ) ??
        currentUser.appUser.dob;
    notifyListeners();
  }

  changeSexuality() async {
    currentUser.appUser.identity = await Get.to(
          IdentityScreen(
            isUpdate: true,
          ),
        ) ??
        currentUser.appUser.identity;
    notifyListeners();
  }

  changeDesires() async {
    currentUser.appUser.desire = await Get.to(
          FantasiesScreen(
            isUpdate: true,
          ),
        ) ??
        currentUser.appUser.desire;
    notifyListeners();
  }

  changeLookingFor() async {
    currentUser.appUser.lookingFor = await Get.to(
          SelectGenderScreen(
            isUpdate: true,
          ),
        ) ??
        currentUser.appUser.lookingFor;
    notifyListeners();
  }
}
