import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/uplift.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/payment_service.dart';
import 'package:hart/core/view_models/base_view_model.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/custom_widgets/dialogs/succes_dialog.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';
import 'package:hart/ui/screens/root_screen/root_screen.dart';

class UpliftPorvider extends BaseViewModel {
  final auth = locator<AuthService>();
  final _db = DatabaseService();
  final paymentService = PaymentService();
  UPlift uPlift = UPlift();

  Map<String, dynamic>? paymentIntentData;
  upliftProfile() async {
    DateTime today = DateTime.now();
    uPlift.boughtAt = DateTime.now();
    uPlift.price = 8;
    uPlift.userId = auth.appUser.id;
    uPlift.endAt = DateTime(
      today.year,
      today.month,
      today.day + 1,
      today.hour,
      today.minute,
      today.second,
    );
    auth.appUser.isUplifted = true;
    auth.appUser.uplift = DateTime.now();
    await _db.upliftUser(uPlift);
    bool update = await _db.updateUserProfile(auth.appUser);
    if (update) {
      Get.back();
    }
  }

  Future<void> makePayment(context) async {
    try {
      String amount = '8';

      paymentIntentData = await paymentService.createPayment("$amount", 'EUR');

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
        // buyspanks();
        upliftProfile();
        successDialog(
          context,
          message: "Payment completed successfully",
          text: "Enjoy premium mode",
          confirm: () {
            Get.back();
          },
        );
      });

      // Get.back();
    } catch (e) {
      print("Exception:$e");
    }
  }

  // buyspanks() async {
  //   setState(ViewState.busy);
  //   spank.boughtAt = DateTime.now();
  //   spank.userId = _auth.appUser.id;
  //   bool isbought = await _db.buySpanks(spank);
  //   auth.appUser.spanks = _auth.appUser.spanks! + spank.no_spanks;
  //   setState(ViewState.idle);

  //   if (isbought) {
  //     Get.snackbar('Succes', 'Spank bought succesfully');
  //     await _db.updateUserProfile(auth.appUser);
  //   }
  // }
}
