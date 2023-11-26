import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/subscripton.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/payment_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';

import '../../../custom_widgets/dialogs/succes_dialog.dart';

class MaestroProvider extends BaseViewModel {
  int dotIndicator = 0;
  final auth = locator<AuthService>();
  final _db = DatabaseService();
  Subscription subscription = Subscription();
  final paymentService = PaymentService();

  Map<String, dynamic>? paymentIntentData;

  MaestroProvider() {
    subscriptions.first.isSelected = true;
    subscription = subscriptions.first;
    notifyListeners();
  }

  List<Subscription> subscriptions = [
    Subscription(
      no_days: 30,
      price: 25,
      weeklyPrice: '(6.20 per week)',
      type: 'month',
    ),
    Subscription(
      no_days: 90,
      price: 59,
      weeklyPrice: '(4.20 per week)',
      type: '3 months',
    ),
    Subscription(
      no_days: 1,
      price: 160,
      weeklyPrice: '(3.20 per week)',
      type: 'year',
    ),
  ];

  selectPlan(index) {
    subscriptions[index].userId = auth.appUser.id;
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
    auth.appUser.isPremiumUser = true;
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

    subscription.userId = auth.appUser.id;

    String id = await _db.buySubscriptionPlan(subscription);
    setState(ViewState.idle);

    if (id != '') {
      auth.appUser.paymentId = id;

      Get.snackbar('Succes', 'Plan bought succesfully');
      await _db.updateUserProfile(auth.appUser);
    }
  }

  Future<void> makePayment(context) async {
    try {
      String amount = subscription.price!.round().toString();

      paymentIntentData = await paymentService.createPayment("$amount", 'USD');

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        merchantDisplayName: 'Talha',
        style: ThemeMode.dark,
      ));
      displayPresentSheet(context);
    } catch (e) {
      print("Exception:@stripe ==> ${e.toString()}");
    }
  }

  displayPresentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        buyPlan();
        successDialog(
          context,
          message: "Payment completed successfully",
          text: "Enjoy premium mode",
          confirm: () {
            Get.back();
            Get.off(MaestroScreen());
          },
        );
      });
    } catch (e) {
      print("Exception:$e");
    }
  }

  changeDot(index) {
    dotIndicator = index;
    notifyListeners();
  }
  // createPayment(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       // 'amount': amount,
  //       'currency': currency,
  //       'payment_method_types[]': 'card'
  //     };
  //     var response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //         body: body,
  //         headers: {
  //           'Authorization': 'Bearer ${Keys.SECRET_KEY}',
  //           'Content-Type': 'application/x-www-form-urlencoded'
  //         });

  //     return jsonDecode(response.body.toString());
  //   } catch (e) {
  //     print("Exception:$e");
  //   }
  // }

  // calculateAmount(String amount) {
  //   final price = int.parse(amount) * 100;
  //   return price.toString();
  // }
}
