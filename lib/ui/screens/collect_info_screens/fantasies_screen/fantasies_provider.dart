import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/ui/custom_widgets/dialogs/custom_snackbar.dart';
import 'package:hart/ui/screens/collect_info_screens/exploring_together/explor_screen.dart';

import '../../../../core/services/database_service.dart';
import '../../../../locator.dart';

class FantasiesProvider extends BaseViewModel {
  // bool isFreindship = false;
  // bool isMarriage = false;
  int selections = 0;
  bool updation = false;
  String desire = '';
  bool filtering = false;
  final currentUser = locator<AuthService>().appUser;
  DatabaseService _db = DatabaseService();
  FantasiesProvider(update, filter) {
    updation = update;
    filtering = filter;
    selectedItems = [];
    getItems();
    notifyListeners();
  }

  List<InfoItem> items = [];
  List<String> selectedItems = [];

  getItems() async {
    // setState(ViewState.busy);
    items = await _db.getDesires();
    notifyListeners();
    // setState(ViewState.idle);
  }

  select(index) {
    // if (filtering) {
    //   for (var item in items) {
    //     // / filter ===> single item selection to be implemented
    //     if (item == items[index]) {
    //       item.isSelected = true;
    //       desire = item.title!;
    //     } else {
    //       item.isSelected = false;
    //     }
    //   }
    //   notifyListeners();
    // } else {
    items[index].isSelected = !items[index].isSelected!;
    if (items[index].isSelected == true) {
      if (!selectedItems.contains(items[index].title)) {
        selectedItems.add(items[index].title!);
      }

      selections++;
    } else {
      selections--;
    }
    notifyListeners();
    // }
  }

  addSelectedItems() async {
    // for (var element in items) {
    //   if (element.isSelected == true) {
    //     selectedItems.add(element.title!);
    //   }
    // }
    currentUser.desire = [];
    currentUser.desire = selectedItems;
    // setState(ViewState.busy);
    // bool isUpdated = await _db.updateUserProfile(currentUser);
    // setState(ViewState.idle);
    // if (isUpdated) {
    if (updation == true) {
      Get.back(result: selectedItems);
    } else {
      if (selectedItems.isNotEmpty) {
        Get.to(
          ExploreScreen(),
        );
      } else {
        customSnackBar('alert!', 'Selection Required');
      }
    }
    // }
    notifyListeners();
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
