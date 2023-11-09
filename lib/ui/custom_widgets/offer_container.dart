import 'package:flutter/material.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

import '../../core/constants/colors.dart';

class Offers extends StatelessWidget {
  String? title;
  String? price;
  String? offer;
  bool? isSelected;
  final onTap;

  Offers({
    this.offer,
    this.price,
    this.title,
    this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                  color: isSelected == true ? pinkColor : whiteColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: pinkColor2,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    style:
                        subtitleText.copyWith(color: lightRed, fontSize: 12.sp),
                  ),
                  Text(
                    price!,
                    style: subHeadingText1,
                  ),
                ],
              ),
            ),
          ),
          offer != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: primaryColor,
                    ),
                    child: Text(
                      offer!,
                      style: buttonTextStyle2.copyWith(
                          color: whiteColor, fontSize: 8.sp),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
