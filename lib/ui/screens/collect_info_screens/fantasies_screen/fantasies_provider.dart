import 'package:hart/core/view_models/base_view_model.dart';

class FantasiesProvider extends BaseViewModel {
  bool isFreindship = false;
  bool isMarriage = false;
  int selections = 0;

  selectMan() {
    isFreindship = !isFreindship;
    if (isFreindship) {
      selections = selections + 1;
    } else {
      selections = selections - 1;
    }
    notifyListeners();
  }

  selectWoman() {
    isMarriage = !isMarriage;
    if (isMarriage) {
      selections = selections + 1;
    } else {
      selections = selections - 1;
    }
    notifyListeners();
  }
}
