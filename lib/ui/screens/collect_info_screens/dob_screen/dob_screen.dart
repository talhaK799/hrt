import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_provider.dart';
import 'package:hart/ui/screens/collect_info_screens/nick_name_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/style.dart';

class DOBScreen extends StatelessWidget {
  const DOBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DobProvider(),
      child: Consumer<DobProvider>(builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 50,
              right: 50,
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
                      'Add date of birth',
                      style: headingText.copyWith(
                        color: blackColor,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomProgressIndicator(
                      value: 1,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                      title: model.pickedDate == null
                          ? 'Example: 12/03/1985'
                          : monthNameDate.format(model.pickedDate!),
                      color: pinkColor,
                      textColor: greyColor,
                      onTap: () {
                        model.pickDate(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 200.h,
                ),
                CustomButton(
                  title: 'CONTINUE',
                  onTap: () {
                    if (model.age < 18) {
                      Get.snackbar('Alert!!', 'Age must be 18 or above');
                    } else {
                      Get.to(
                        NickNameScreen(),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
