import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';

// ignore: must_be_immutable
class CustomTextField2 extends StatelessWidget {
  String? hintText;
  final validator;
  final onChange;
  // bool? obscure;
  // Widget? suffex;
  TextEditingController? controller;

  CustomTextField2({
    this.hintText,
    required this.onChange,
    required this.validator,
    this.controller,
    // this.obscure,
    // this.suffex,
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
              color: pinkColor,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: pinkColor2)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, top: 10),
          child: TextFormField(
            validator: validator,
            controller: controller,
            // obscureText: obscure ?? false,
            obscuringCharacter: '*',
            cursorColor: primaryColor,
            style: subHeadingTextStyle.copyWith(
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: subHeadingTextStyle.copyWith(
                  color: greyColor,
                ),
                errorStyle: subHeadingTextStyle.copyWith(
                  color: primaryColor,
                ),
                // suffix: suffex,
                border: InputBorder.none,),
          ),
        ),
      ],
    );
  }
}
