import 'package:hart/core/view_models/base_view_model.dart';

class UpliftPorvider extends BaseViewModel {
  int currentIndex = 0;

  select(index) {
    currentIndex = index;
    notifyListeners();
  }
}
