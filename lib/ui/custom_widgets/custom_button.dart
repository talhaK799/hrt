import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

class CustomButton extends StatelessWidget {
  String? icon;
  String title;
  final onTap;
  Color? color;
  Color? textColor;

  CustomButton({
    this.icon,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints.tight(Size.fromHeight(60.h)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color ?? primaryColor,
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
                        scale: 3.5,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        title.toString(),
                        style: buttonTextStyle,
                      ),
                    ],
                  )
                : Expanded(
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Text(
                          title,
                          style: buttonTextStyle.copyWith(
                            color: textColor ?? whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
