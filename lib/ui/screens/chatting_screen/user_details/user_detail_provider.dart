import 'package:hart/core/view_models/base_view_model.dart';

class UserDetailProvider extends BaseViewModel {
    int dotIndex = 0;


 updateIndex(index) {
    dotIndex = index;
    print('current index==> $index=====> $dotIndex');
    notifyListeners();
  }
}