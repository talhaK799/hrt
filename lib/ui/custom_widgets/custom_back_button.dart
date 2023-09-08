import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        '$staticAsset/Back.png',
        scale: 2.8,
      ),
    );
  }
}