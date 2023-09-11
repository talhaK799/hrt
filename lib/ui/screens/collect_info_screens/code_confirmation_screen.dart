import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/style.dart';

class CodeConfirmationScreen extends StatelessWidget {
  const CodeConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 50,
            right: 50,
            top: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Conformation Code',
                    style: headingText.copyWith(
                      color: blackColor,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Please enter 4-digit code sent to your email.',
                    style: subHeadingTextStyle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    defaultPinTheme: PinTheme(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: greyColor,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ],
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(
                          4.r,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'You can request code again in ',
                  style: descriptionTextStyle.copyWith(
                      color: blackColor, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: '30s',
                      style: descriptionTextStyle.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
              CustomButton(
                title: 'CONTINUE',
                onTap: () {},
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
