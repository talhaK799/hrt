import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class SelectGenderProvider extends BaseViewModel {
  DatabaseService _db = DatabaseService();
  bool isClicked = false;
  SelectGenderProvider() {
    getItems();
  }

  List<InfoItem> items = [];

  getItems() async {
    setState(ViewState.busy);
    items = await _db.getPersonalities();
    setState(ViewState.idle);
  }

  select(index) {
    items[index].isSelected = !items[index].isSelected!;
    notifyListeners();
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
