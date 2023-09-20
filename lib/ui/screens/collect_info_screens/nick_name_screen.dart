import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/custom_widgets/custom_text_field_2.dart';
import 'package:hart/ui/screens/collect_info_screens/idetity_screen/identity_screen.dart';

import '../../../../core/constants/style.dart';

class NickNameScreen extends StatelessWidget {
  const NickNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 40,
          right: 50,
          top: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(
                  isWhite: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Choose your nickname',
                  style: headingText.copyWith(
                    color: blackColor,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomProgressIndicator(
                  value: 2,
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomTextField2(
                  onChange: (val) {},
                  validator: (val) {},
                  hintText: 'Example: James',
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              title: 'CONTINUE',
              onTap: () {
                Get.to(
                  IdentityScreen(),
                );
              },
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
