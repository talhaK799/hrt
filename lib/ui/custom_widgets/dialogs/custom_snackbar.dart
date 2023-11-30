import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

customSnackBar(title, message) {
  return Get.snackbar(
    title,
    '',
    colorText: primaryColor,
    backgroundColor: whiteColor,
    messageText: Text(
      message,
      style: miniText.copyWith(
        color: lightRed,
        fontSize: 15.sp,
      ),
    ),
  );
}
