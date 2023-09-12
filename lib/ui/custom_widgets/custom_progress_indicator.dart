import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hart/core/constants/style.dart';

import '../../core/constants/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final value;
  const CustomProgressIndicator({
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'step $value of 08',
          style: headingText.copyWith(
            color: greyColor2,
            fontSize: 12.sp,
          ),
        ),
        LinearProgressIndicator(
          value: value * 0.125,
          color: primaryColor,
          backgroundColor: greyColor,
        )
      ],
    );
  }
}