import 'package:hart/core/view_models/base_view_model.dart';

class HomeProvider extends BaseViewModel {
  int currentIndex = 0;

  updateIndex(index) {
    currentIndex = index;
    print('current index==> $index=====> $currentIndex');
    notifyListeners();
  }
}
