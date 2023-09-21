import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/info_item.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';

class IdentityProvider extends BaseViewModel {
  DatabaseService _db = DatabaseService();
  bool isClicked = false;
  IdentityProvider() {
    getItems();
  }

  List<InfoItem> items = [];

  getItems() async {
    setState(ViewState.busy);
    items = await _db.getIdentity();
    setState(ViewState.idle);
  }

  select(index) {
    items[index].isSelected = !items[index].isSelected !;
    notifyListeners();
  }
}
