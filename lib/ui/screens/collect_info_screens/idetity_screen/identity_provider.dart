import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/custom_snackbar.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_screen.dart';

class IdentityProvider extends BaseViewModel {
  DatabaseService _db = DatabaseService();
  final currentUser = locator<AuthService>().appUser;
  String identity = '';
  bool isClicked = false;
  bool updation = false;
  IdentityProvider(isupdate) {
    getItems();
    updation = isupdate;
    notifyListeners();
  }

  List<InfoItem> items = [];
  List<String> selectedItems = [];

  getItems() async {
    // setState(ViewState.busy);
    items = await _db.getIdentity();
    notifyListeners();
    // setState(ViewState.idle);
  }

  select(index) {
    // items[index].isSelected = !items[index].isSelected!;

    for (var i = 0; i < items.length; i++) {
      if (index == i) {
        items[i].isSelected = true;
        identity = items[i].title!;
      } else {
        items[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  addSelectedItems() async {
    // currentUser.identity = items[index].title;
    currentUser.identity = identity;
    // setState(ViewState.busy);
    // bool isUpdated = await _db.updateUserProfile(currentUser);
    // setState(ViewState.idle);
    // if (isUpdated) {
    if (updation == true) {
      Get.back(result: identity);
    } else {
      if (identity.isEmpty || identity == null) {
        customSnackBar('alert!', 'Selection Required');
      } else {
        Get.to(SelectGenderScreen());
      }
    }
    // }
    notifyListeners();
  }
}
