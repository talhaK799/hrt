import 'package:flutter/material.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class CustomProfileTile extends StatelessWidget {
  final title;
  String? icon;
  bool? isWhite;
  bool? isList;
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
    this.isList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        // margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: color ?? whiteColor,
          // boxShadow: isWhite == true ? boxShadow : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            icon != null
                ? Row(
                    children: [
                      Image.asset(
                        '$staticAsset/$icon',
                        scale: 3,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isList == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var i = 0; i < title.length; i++)
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  title.length <= 3
                                      ? '${title[i].toString()}, '
                                      : '. . . .',
                                  style: buttonTextStyle.copyWith(
                                    color: textColor ?? blackColor,
                                  ),
                                ),
                              ),
                          ],
                        )
                      : Text(
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
