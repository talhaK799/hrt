import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/phone_no_screen/add_phone_no.dart';

import '../../../core/constants/style.dart';

class BuyPlanScreen extends StatelessWidget {
  const BuyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            '$staticAsset/couple.png',
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.3.sh),
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Welcome To ',
                          style: headingText.copyWith(
                            color: blackColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Hart',
                              style: headingText.copyWith(
                                color: primaryColor,
                              ),
                            )
                          ]),
                    ),
                    Text(
                      'You’re close to meeting your people. Speed things up with Majestic Maestro',
                      textAlign: TextAlign.center,
                      style: descriptionTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    _plan(),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(title: 'BECOME A MAESTRO', onTap: () {}),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///
          /// Close button
          ///
          closeButtton(),
        ],
      ),
    );
  }

  GestureDetector closeButtton() {
    return GestureDetector(
      onTap: () {
        Get.to(
          AddPhoneNumber(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 30,
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            '$staticAsset/Cross Icon.png',
            scale: 2.5,
          ),
        ),
      ),
    );
  }

  _plan() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 0.5.sh,
            width: 100.h,
            decoration: BoxDecoration(
              color: Color(0xFFF0D9D9),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.5.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FEATURE',
                    style: subHeadingTextStyle.copyWith(
                      color: blackColor,
                    ),
                  ),
                  Text(
                    'BASIC',
                    style: subHeadingTextStyle.copyWith(
                      color: blackColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'MAESTRO',
                      style: subHeadingTextStyle.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text('SEND LIKES'),
                  Text(
                    'LIMITED',
                    style: subHeadingTextStyle.copyWith(
                      fontSize: 12.sp,
                      color: blackColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'UNLIMITED',
                      style: subHeadingTextStyle.copyWith(
                        fontSize: 12.sp,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text('SEE WHO LIKES YOU'),
                  cross(),
                  tick(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text('GET 1 FREE SPANK A DAY'),
                  cross(),
                  tick(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text('LAST SEEN ONLINE'),
                  cross(),
                  tick(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text('SEARCH BY DESIRE'),
                  cross(),
                  tick(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text('MAKE PHOTOS PRIVATE'),
                  cross(),
                  tick(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  tick() {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Image.asset(
        '$staticAsset/Vector.png',
        scale: 4,
      ),
    );
  }

  cross() {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Image.asset(
        '$staticAsset/Cross Icon.png',
        color: blackColor,
        scale: 4.5,
      ),
    );
  }

  _text(text) {
    return SizedBox(
      width: 90.w,
      child: Text(
        text,
        style: subHeadingTextStyle.copyWith(
          fontSize: 12.sp,
          color: blackColor,
        ),
      ),
    );
  }
}
