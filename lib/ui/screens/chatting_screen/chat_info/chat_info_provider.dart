import 'package:hart/core/view_models/base_view_model.dart';

class ChatInfoProvider extends BaseViewModel {
  bool isMute = false;

  changeMute(val) {
    isMute = val;
    notifyListeners();
  }
}
