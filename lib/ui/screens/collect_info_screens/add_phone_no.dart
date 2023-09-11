import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_text_field_2.dart';
import 'package:hart/ui/screens/collect_info_screens/code_confirmation_screen.dart';

import '../../../core/constants/style.dart';

class AddPhoneNumber extends StatelessWidget {
  const AddPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Phone no',
                  style: headingText.copyWith(
                    color: blackColor,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                CustomTextField2(
                    onChange: (val) {},
                    hintText: 'Phone no',
                    validator: (val) {}),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              title: 'CONTINUE',
              onTap: () {
                Get.to(
                  CodeConfirmationScreen(),
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
