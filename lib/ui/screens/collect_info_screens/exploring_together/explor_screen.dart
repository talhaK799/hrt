import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/constants/style.dart';
import '../add_photo/add_photo_screen.dart';
import 'exploring_provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(),
      child: Consumer<ExploreProvider>(builder: (context, model, child) {
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
                        'Exploring together',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomProgressIndicator(
                        value: 6,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          '$staticAsset/picture.png',
                          // height: 0.41.sh,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Pair your account with a partner.No connections or chat will be shared.',
                    style: descriptionTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    title: 'Invite partner',
                    onTap: () {
                      Share.share(
                        'Join me on Feeld as my partner. You need to be logged in and tap on this link to accept the invite: https://feeld.app.link/j3Ge2crT7Db',
                      );
                    },
                    color: pinkColor,
                    textColor: primaryColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    title: 'CONTINUE',
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // Get.to(
                      //   AddPhotoScreen(),
                      // );
                      Navigator.push(
                        context,
                        PageFromRight(
                          page: AddPhotoScreen(),
                        ),
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
