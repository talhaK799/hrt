import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/view_models/base_view_model.dart';

import '../../../../core/services/database_service.dart';

class FantasiesProvider extends BaseViewModel {
  // bool isFreindship = false;
  // bool isMarriage = false;
  int selections = 0;

  DatabaseService _db = DatabaseService();
  FantasiesProvider() {
    getItems();
  }

  List<InfoItem> items = [];

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
