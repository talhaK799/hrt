import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';

import '../../../../core/services/auth_service.dart';
import 'select_gender_screen.dart';

class SelectGenderProvider extends BaseViewModel {
  DatabaseService _db = DatabaseService();

  final currentUser = locator<AuthService>().appUser;
  bool isClicked = false;
  bool filter = false;

  SelectGenderProvider(isFiltering) {
    filter = isFiltering;
    getItems();
  }

  List<InfoItem> items = [];
  String? selectedItem;

  getItems() async {
    setState(ViewState.busy);
    items = [];
    items = await _db.getPersonalities();
    setState(ViewState.idle);
  }

  select(index) {
    for (var item in items) {
      if (item == items[index]) {
        item.isSelected = true;
        selectedItem = item.title;
        if (!filter) {
          currentUser.lookingFor = selectedItem;
        }
      } else {
        item.isSelected = false;
      }
    }
    // items[index].isSelected = !items[index].isSelected!;
    notifyListeners();
  }

  addSelectedItems() async {
    // for (var element in items) {
    //   if (element.isSelected == true) {
    //     selectedItems.add(element.title!);
    //   }
    // }
    setState(ViewState.busy);
    bool isUpdated = await _db.updateUserProfile(currentUser);
    setState(ViewState.idle);
    if (isUpdated) {
      Get.to(
        FantasiesScreen(),
      );
    }
  }
  // bool isMan = false;
  // bool isWoman = false;

  // selectMan() {
  //   isMan = true;
  //   isWoman = false;
  //   notifyListeners();
  // }

  // selectWoman() {
  //   isWoman = true;
  //   isMan = false;
  //   notifyListeners();
  // }
}
