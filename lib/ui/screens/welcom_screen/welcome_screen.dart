import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/base_screen.dart';
import 'package:hart/ui/screens/buy_plan/buy_plan_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/add_phone_no.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      image: '$staticAsset/Ellipse3.svg',
      backgroundColor: primaryColor.withOpacity(0.76),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: Image.asset(
                '$logoPath/logo2.png',
                scale: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Text(
                'WELCOME TO HART',
                style: headingText.copyWith(
                  fontSize: 40.sp,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
                'Hart enclose the mission to March open minded people seeking for something different! Be respectful with your match, discover and have fun!',
                style: subHeadingTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                )),
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Please confirm that you’re over 18',
              style: subHeadingTextStyle.copyWith(
                color: blackColor,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomButton(
              title: 'CONFIRM',
              onTap: () {
                Get.to(
                  BuyPlanScreen(),
                );
                // if (model.formkey.currentState!.validate()) {
                //   // model.signUp();
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
