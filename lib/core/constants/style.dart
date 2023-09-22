// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';

// final bodyTextStyleRoboto = TextStyle(
//   fontSize: 16.sp,
//   fontFamily: nunitoFont,
// );
final bodyTextStyle = TextStyle(
  fontSize: 18.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
  color: blackColor,
);

final headingText = TextStyle(
  fontSize: 24.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w700,
  color: whiteColor,
);
final subHeadingText1 = TextStyle(
  fontSize: 20.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w700,
  color: primaryColor,
);
final subHeadingTextWhite = TextStyle(
  fontSize: 20.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w700,
  color: whiteColor,
);
final descriptionTextStyle = TextStyle(
  fontSize: 16.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
);

final subHeadingTextStyle = TextStyle(
  fontSize: 16.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w700,
  color: whiteColor,
);
final subHeadingTextStyle2 = TextStyle(
  fontSize: 16.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w700,
  color: blackColor,
);
final buttonTextStyle = TextStyle(
  fontSize: 14.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
  color: whiteColor,
);
final buttonTextStyleRed = TextStyle(
  fontSize: 14.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
  color: primaryColor,
);
final buttonTextStyle2 = TextStyle(
  fontSize: 12.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
);
final buttonTextStyleGrey = TextStyle(
  fontSize: 12.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
  color: greyColor2,
);

final miniText = TextStyle(
  fontSize: 10.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w600,
  color: blackColor,
);

final subtitleText = TextStyle(
  fontSize: 14.sp,
  fontFamily: nunitoFont,
  fontWeight: FontWeight.w400,
  color: lightRed,
);

final sizeBox30 = SizedBox(
  height: 30.h,
);
final sizeBox10 = SizedBox(
  height: 10.h,
);
final sizeBoxw10 = SizedBox(
  width: 10.w,
);
final sizeBox20 = SizedBox(
  height: 20.h,
);

final boxShadow = [
  BoxShadow(
    color: greyColor,
    offset: Offset(
      3.0,
      3.0,
    ),
    blurRadius: 10.0,
    spreadRadius: 2.0,
  ), //BoxShadow
  BoxShadow(
    color: Colors.white,
    offset: const Offset(0.0, 0.0),
    blurRadius: 0.0,
    spreadRadius: 0.0,
  ), //BoxShadow
];
