import 'package:hart/core/view_models/base_view_model.dart';

class GroupDetailProvider extends BaseViewModel {
  bool isMute = false;

  changeMute(val) {
    isMute = val;
    notifyListeners();
  }
}