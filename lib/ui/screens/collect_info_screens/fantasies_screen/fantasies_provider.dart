import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/ui/screens/collect_info_screens/exploring_together/explor_screen.dart';

import '../../../../core/services/database_service.dart';
import '../../../../locator.dart';

class FantasiesProvider extends BaseViewModel {
  // bool isFreindship = false;
  // bool isMarriage = false;
  int selections = 0;

  final currentUser = locator<AuthService>().appUser;
  DatabaseService _db = DatabaseService();
  FantasiesProvider() {
    getItems();
  }

  List<InfoItem> items = [];
  List<String> selectedItems = [];

  getItems() async {
    setState(ViewState.busy);
    items = await _db.getDesires();
    setState(ViewState.idle);
  }

  select(index) {
    items[index].isSelected = !items[index].isSelected!;
    if (items[index].isSelected == true) {
      selections++;
    } else {
      selections--;
    }
    notifyListeners();
  }

  addSelectedItems() async {
    // for (var element in items) {
    //   if (element.isSelected == true) {
    //     selectedItems.add(element.title!);
    //   }
    // }

    // currentUser.desire = selectedItems;
    // setState(ViewState.busy);
    // bool isUpdated = await _db.updateUserProfile(currentUser);
    // setState(ViewState.idle);
    // if (isUpdated) {
      Get.to(
        ExploreScreen(),
      );
    // }
  }

  // selectMan() {
  //   isFreindship = !isFreindship;
  //   if (isFreindship) {
  //     selections = selections + 1;
  //   } else {
  //     selections = selections - 1;
  //   }
  //   notifyListeners();
  // }

  // selectWoman() {
  //   isMarriage = !isMarriage;
  //   if (isMarriage) {
  //     selections = selections + 1;
  //   } else {
  //     selections = selections - 1;
  //   }
  //   notifyListeners();
  // }
}
