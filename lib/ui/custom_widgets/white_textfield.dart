import 'package:flutter/material.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';

import '../../core/constants/colors.dart';

class CustomTextFieldWhite extends StatelessWidget {
  String? hintText;
  final onChange;
  final validator;
  CustomTextFieldWhite({
    required this.onChange,
    required this.validator,
    this.hintText,
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
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: greyColor)),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            // width: 70.w,
            // height: 70.h,
            padding: EdgeInsets.fromLTRB(0, 20, 30, 30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              '$staticAsset/arrow.png',
              scale: 2.8,
              color: greyColor2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 10),
          child: TextFormField(
            // obscureText: obscure ?? false,
            obscuringCharacter: '*',
            onChanged: onChange,
            validator: validator,
            cursorColor: greyColor,
            style: subHeadingTextStyle.copyWith(
              color: blackColor,
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                errorStyle: subHeadingTextStyle.copyWith(color: primaryColor),
                // suffix: suffex,
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
