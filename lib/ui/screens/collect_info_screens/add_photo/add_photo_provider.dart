import 'package:hart/core/view_models/base_view_model.dart';

class AddPhotoProvider extends BaseViewModel {
  bool isMan = false;
  bool isWoman = false;

  selectMan() {
    isMan = true;
    isWoman = false;
    notifyListeners();
  }

  selectWoman() {
    isWoman = true;
    isMan = false;
    notifyListeners();
  }
}
