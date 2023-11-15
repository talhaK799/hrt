import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/spank.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/payment_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/succes_dialog.dart';
import 'package:hart/ui/screens/profile_screen/profile_screen.dart';

class KingHartProvider extends BaseViewModel {
  int currentIndex = 0;
  final _auth = locator<AuthService>();
  final _db = DatabaseService();
  Spanks spank = Spanks();
  Map<String, dynamic>? paymentIntentData;
  final paymentService = PaymentService();
  KingHartProvider() {
    spank = spanks.first;

    spank.isSelected = true;
  }

  List<Spanks> spanks = [
    Spanks(
      no_spanks: 1,
      price: 5,
      offer: null,
    ),
    Spanks(
      no_spanks: 5,
      price: 15,
      offer: '20 % OFF',
    ),
    Spanks(
      no_spanks: 15,
      price: 25,
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

  Future<void> makePayment(context) async {
    try {
      String amount = spank.price!.round().toString();

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
        buyspanks();
        successDialog(
          context,
          message: "Payment completed successfully",
          text: "Enjoy premium mode",
          confirm: () {
            Get.back();
            Get.off(ProfileScreen());
          },
        );
      });
    } catch (e) {
      print("Exception:$e");
    }
  }

  buyspanks() async {
    setState(ViewState.busy);
    spank.boughtAt = DateTime.now();
    spank.userId = _auth.appUser.id;
    bool isbought = await _db.buySpanks(spank);
    _auth.appUser.spanks = _auth.appUser.spanks! + spank.no_spanks;
    setState(ViewState.idle);

    if (isbought) {
      Get.snackbar('Succes', 'Spank bought succesfully');
      await _db.updateUserProfile(_auth.appUser);
    }
  }
}
