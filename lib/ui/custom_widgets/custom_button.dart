import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

class CustomButton extends StatelessWidget {
  String? icon;
  final title;
  final onTap;
  CustomButton({
    this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(
            32.r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Row(
                    children: [
                      Image.asset(
                        '$staticAsset/$icon',
                        scale: 2.5,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        title,
                        style: buttonTextStyle,
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      title,
                      style: buttonTextStyle,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
