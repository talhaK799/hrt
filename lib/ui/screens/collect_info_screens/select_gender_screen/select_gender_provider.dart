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
  bool updattion = false;

  SelectGenderProvider(isFiltering, update) {
    filter = isFiltering;
    updattion = update;
    getItems();
  }

  List<InfoItem> items = [];
  List<String> selections = [];
  String? selectedItem;

  getItems() async {
    setState(ViewState.busy);
    items = [];
    items = await _db.getPersonalities();
    setState(ViewState.idle);
  }

  /// single selection

  select(index) {
    if (filter) {
      for (var item in items) {
        if (item == items[index]) {
          item.isSelected = true;
          selectedItem = item.title;
        } else {
          item.isSelected = false;
        }
      }
    } else {
      items[index].isSelected = !items[index].isSelected!;
    }

    notifyListeners();
  }

  addSelectedItems() async {
    currentUser.lookingFor = [];
    for (var element in items) {
      if (element.isSelected == true) {
        print('element==> ${element.title}');
        selections.add(element.title!);
      }
    }
    currentUser.lookingFor = selections;
    // print('first element==> ${selections.first}');
    // setState(ViewState.busy);

    // bool isUpdated = await _db.updateUserProfile(currentUser);
    // setState(ViewState.idle);
    // if (isUpdated) {
    if (updattion) {
      await _db.updateUserProfile(currentUser);
      Get.back(result: selections);
    } else {
      Get.to(
        FantasiesScreen(),
      );
    }
    // }

    notifyListeners();
    // }
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
