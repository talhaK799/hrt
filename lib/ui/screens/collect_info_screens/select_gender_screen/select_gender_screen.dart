import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectGenderProvider(),
      child: Consumer<SelectGenderProvider>(builder: (context, model, child) {
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
                      'Who are you looking for?',
                      style: headingText.copyWith(
                        color: blackColor,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomProgressIndicator(
                      value: 4,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                      title: 'Man',
                      onTap: () {
                        model.selectMan();
                      },
                      color: model.isMan ? primaryColor : pinkColor,
                      textColor: model.isMan ? whiteColor : primaryColor,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      title: 'Woman',
                      onTap: () {
                        model.selectWoman();
                      },
                      color: model.isWoman ? primaryColor : pinkColor,
                      textColor: model.isWoman ? whiteColor : primaryColor,
                    )
                  ],
                ),
                Spacer(),
                CustomButton(
                  title: 'CONTINUE',
                  onTap: () {
                    Get.to(
                      FantasiesScreen(),
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
      }),
    );
  }
}
