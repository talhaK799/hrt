import 'package:flutter/material.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class CustomProfileTile extends StatelessWidget {
  final title;
  String? icon;
  bool? isWhite;
  Color? color;
  Color? iconColor;
  Color? textColor;
  final onTap;

  CustomProfileTile({
    required this.title,
    this.icon,
    this.color,
    this.iconColor,
    this.textColor,
    this.isWhite = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: color ?? whiteColor,
          boxShadow: isWhite == true ? boxShadow : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            icon != null
                ? Image.asset(
                    '$staticAsset/$icon',
                    scale: 3,
                  )
                : Container(),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: buttonTextStyle.copyWith(
                      color: textColor ?? blackColor,
                    ),
                  ),
                  Image.asset(
                    '$staticAsset/arrow.png',
                    scale: 3.5,
                    color: iconColor ?? blackColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
