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
  bool? isSpank;
  Color? color;
  Color? iconColor;
  Color? textColor;
  final onTap;
  bool? isMaestro;

  CustomProfileTile(
      {required this.title,
      this.icon,
      this.color,
      this.iconColor,
      this.textColor,
      this.isWhite = true,
      this.isSpank = false,
      this.isList,
      required this.onTap,
      this.isMaestro = false});

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
                : isMaestro == true
                    ? Row(
                        children: [
                          Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xFF980000).withOpacity(0.3)),
                            child: Center(
                                child: UnconstrainedBox(
                              child: Text(
                                "M",
                                style: bodyTextStyle.copyWith(
                                    color: Color(0xFF980000), fontSize: 14.sp),
                              ),
                            )),
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
                      ? Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (var i = 0; i < title.length; i++)
                                // title.length < 3
                                // ?
                                Expanded(
                                  child: Text(
                                    '${title[i].toString()},',
                                    style: buttonTextStyle.copyWith(
                                      color: textColor ?? blackColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              // :
                              // Text(
                              //     '. . . ',
                              //     style: buttonTextStyle.copyWith(
                              //       color: textColor ?? blackColor,
                              //     ),
                              //   ),
                            ],
                          ),
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
