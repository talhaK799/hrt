import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';

successDialog(BuildContext context,
    {String? message, String? text, final confirm}) {
  CoolAlert.show(
    barrierDismissible: false,
    confirmBtnColor: primaryColor,
    backgroundColor: pinkColor,
    context: context,
    type: CoolAlertType.success,

    // title: "$message",
    text: "$message",
    onConfirmBtnTap: confirm,
  );
}
