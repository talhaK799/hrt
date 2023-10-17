import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';

class CustomBackButton extends StatelessWidget {
  bool? isWhite;
  CustomBackButton({
    this.isWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        isWhite == true ? '$staticAsset/back2.png' : '$staticAsset/Back.png',
        scale: 2.8,
      ),
    );
  }
}
