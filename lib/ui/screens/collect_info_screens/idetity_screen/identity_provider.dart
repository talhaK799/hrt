import 'package:hart/core/view_models/base_view_model.dart';

class IdentityProvider extends BaseViewModel {
  bool isClicked = false;

  select() {
    isClicked = !isClicked;
    notifyListeners();
  }
}
