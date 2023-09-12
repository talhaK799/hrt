import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/screens/collect_info_screens/idetity_screen/identity_provider.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class IdentityScreen extends StatelessWidget {
  const IdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IdentityProvider(),
      child: Consumer<IdentityProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
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
                        'Your identify as...',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomProgressIndicator(
                        value: 3,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomButton(
                        title: 'Straight',
                        onTap: () {
                          model.select();
                        },
                        color: model.isClicked ? primaryColor : pinkColor,
                        textColor: model.isClicked ? whiteColor : primaryColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200.h,
                  ),
                  CustomButton(
                    title: 'CONTINUE',
                    onTap: () {
                      Get.to(
                        SelectGenderScreen(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}


