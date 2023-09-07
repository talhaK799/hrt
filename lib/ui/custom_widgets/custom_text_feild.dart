import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';

import '../../core/constants/strings.dart';

class CustomTextField extends StatelessWidget {
  String? hintText;
  final prefixIcon;
  final validator;
  final onChange;
  bool? obscure;
  Widget? suffex;
  TextEditingController? controller;

  CustomTextField({
    this.hintText,
    required this.onChange,
    required this.validator,
    required this.prefixIcon,
    this.controller,
    this.obscure,
    this.suffex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: 1.sw,
          height: 65.h,
          decoration: BoxDecoration(
              color: whiteColor2,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: whiteColor3)),
        ),
        Container(
          // width: 70.w,
          // height: 70.h,
          padding: EdgeInsets.fromLTRB(30, 20, 0, 30),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            '$staticAsset/$prefixIcon',
            scale: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 10),
          child: TextFormField(
            validator: validator,
            controller: controller,
            obscureText: obscure ?? false,
            obscuringCharacter: '*',
            cursorColor: whiteColor,
            style: subHeadingTextStyle,
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 45),
                hintText: hintText,
                hintStyle: subHeadingTextStyle,
                errorStyle: subHeadingTextStyle,
                suffix: suffex,
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
