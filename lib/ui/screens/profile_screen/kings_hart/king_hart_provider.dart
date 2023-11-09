import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/spank.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class KingHartProvider extends BaseViewModel {
  int currentIndex = 0;
  final _auth = locator<AuthService>();
  final _db = DatabaseService();
  Spanks spank = Spanks();

  List<Spanks> spanks = [
    Spanks(
      no_spanks: 1,
      price: '€ 5',
      offer: null,
    ),
    Spanks(
      no_spanks: 5,
      price: '€ 15',
      offer: '20 % OFF',
    ),
    Spanks(
      no_spanks: 5,
      price: '€ 25',
      offer: '50 % OFF',
    ),
  ];

  select(index) {
    spanks[index].userId = _auth.appUser.id;
    spank = Spanks();
    // spanks[index].isSelected = !spanks[index].isSelected!;
    for (var element in spanks) {
      if (element == spanks[index]) {
        element.isSelected = true;
        spank = element;
        print('selected spank ${spank.toJson()}');
      } else {
        element.isSelected = false;
      }
    }
    notifyListeners();
  }

  buyspanks() async {
    setState(ViewState.busy);
    spank.boughtAt = DateTime.now();
    bool isbought = await _db.buySpanks(spank);
    _auth.appUser.spanks = _auth.appUser.spanks! + spank.no_spanks;
    setState(ViewState.idle);

    if (isbought) {
      Get.snackbar('Succes', 'Spank bought succesfully');
      await _db.updateUserProfile(_auth.appUser);
    }
  }
}
