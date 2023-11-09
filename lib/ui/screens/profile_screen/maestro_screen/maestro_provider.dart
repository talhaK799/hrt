import 'package:get/get.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/subscripton.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';

class MaestroProvider extends BaseViewModel {
  int currentIndex = 0;
  final _auth = locator<AuthService>();
  final _db = DatabaseService();
  Subscription subscription = Subscription();

  List<Subscription> subscriptions = [
    Subscription(
      no_days: 30,
      price: '\$ 25',
      weeklyPrice: '(6.20 per week)',
      type: 'month',
    ),
    Subscription(
      no_days: 90,
      price: '\$ 59',
      weeklyPrice: '(4.20 per week)',
      type: '3 months',
    ),
    Subscription(
      no_days: 1,
      price: '\$ 160',
      weeklyPrice: '(3.20 per week)',
      type: 'year',
    ),
  ];

  selectPlan(index) {
    subscriptions[index].userId = _auth.appUser.id;
    subscription = Subscription();
    // spanks[index].isSelected = !spanks[index].isSelected!;
    for (var element in subscriptions) {
      if (element == subscriptions[index]) {
        element.isSelected = true;
        subscription = element;
        print('selected spank ${subscription.toJson()}');
      } else {
        element.isSelected = false;
      }
    }
    notifyListeners();
  }

  buyPlan() async {
    DateTime today = DateTime.now();
    setState(ViewState.busy);
    _auth.appUser.isPremiumUser = true;
    subscription.boughtAt = DateTime.now();
    if (subscription.type == 'month') {
      subscription.expiredAt = DateTime(
        today.year,
        today.month + 1,
        today.day,
        today.hour,
        today.minute,
        today.second,
      );
    } else if (subscription.type == '3 months') {
      subscription.expiredAt = DateTime(
        today.year,
        today.month + 3,
        today.day,
        today.hour,
        today.minute,
        today.second,
      );
    } else if (subscription.type == 'year') {
      subscription.expiredAt = DateTime(
        today.year + 1,
        today.month,
        today.day,
        today.hour,
        today.minute,
        today.second,
      );
    }

    String id = await _db.buySubscriptionPlan(subscription);
    setState(ViewState.idle);

    if (id.isNotEmpty) {
      _auth.appUser.paymentId = id;

      Get.snackbar('Succes', 'Plan bought succesfully');
      await _db.updateUserProfile(_auth.appUser);
    }
  }
}
