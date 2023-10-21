import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class EditProfileProvider extends BaseViewModel {
  final currentUser = locator<AuthService>();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseService();
  bool isIncoginito = false;
  DateTime? pickedDate;
  String interst = '';
  String desire = '';

  // DateTime? dob;

  EditProfileProvider() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    currentUser.appUser = await db.getAppUser(currentUser.appUser.id);
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
    currentUser.appUser.lookingFor!.add(interst);
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
    isIncoginito = val;
    notifyListeners();
  }
}
