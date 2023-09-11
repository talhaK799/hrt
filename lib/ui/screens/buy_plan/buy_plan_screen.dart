import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/collect_info_screens/add_phone_no.dart';

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
                      'You’re close to meeting your people. \nSpeed things up with Majestic Membership',
                      textAlign: TextAlign.center,
                      style: descriptionTextStyle.copyWith(
                        color: blackColor,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    _plan(),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(title: 'BY PLAN', onTap: () {}),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
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
          ),
        ],
      ),
    );
  }

  _plan() {
    return Container(
      height: 0.5.sh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FEATURE',
                  style: subHeadingTextStyle.copyWith(
                    color: blackColor,
                  ),
                ),
                Text(
                  'SEND LIKES',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
                Text(
                  'SEE WH LIKES YOU',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
                Text(
                  'GET 1 FREE PING A DAY',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
                Text(
                  'LAST SEEN ONLINE',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
                Text(
                  'SEARCH BY DESIRE',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
                Text(
                  'MAKE PHOTOS PRIVATE',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BASIC',
                  style: subHeadingTextStyle.copyWith(
                    color: blackColor,
                  ),
                ),
                Text(
                  'LIMITED',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
                Image.asset(
                  '$staticAsset/Cross Icon.png',
                  color: blackColor,
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Cross Icon.png',
                  color: blackColor,
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Cross Icon.png',
                  color: blackColor,
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Cross Icon.png',
                  color: blackColor,
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Cross Icon.png',
                  color: blackColor,
                  scale: 4,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF0D9D9),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PREMIUM',
                  style: subHeadingTextStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
                Text(
                  'UNLIMITED',
                  style: subHeadingTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: primaryColor,
                  ),
                ),
                Image.asset(
                  '$staticAsset/Vector.png',
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Vector.png',
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Vector.png',
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Vector.png',
                  scale: 4,
                ),
                Image.asset(
                  '$staticAsset/Vector.png',
                  scale: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
