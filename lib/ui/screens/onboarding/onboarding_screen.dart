import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/screens/auth_screens/auth_screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../custom_widgets/custom_onboarding_card.dart';
import 'onboarding_view_model.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(),
      child: Scaffold(
        body: Consumer<OnboardingViewModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                ///
                /// Onboarding screen
                ///
                Container(
                  child: PageView.builder(
                    controller: model.pageController,
                    itemCount: model.onboardingList.length,
                    itemBuilder: (context, index) {
                      return CustomOnboardingCard(
                        onboarding: model.onboardingList[index],
                      );
                    },
                    onPageChanged: (value) {
                      model.updatePage(value);
                    },
                  ),
                ),

                ///
                /// Dots indicator and buttons
                ///
                Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20.h),

                          ///
                          /// bottom button and skip
                          ///
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///
                                /// dots
                                ///
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: DotsIndicator(
                                    dotsCount: model.onboardingList.length,
                                    position: model.currentPageIndex,
                                    decorator: DotsDecorator(
                                      color: seconderyColor,
                                      activeColor: primaryColor,
                                      size: Size(10.0, 10.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      activeSize: Size(32.0, 9.0),
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),

                                ///
                                /// button
                                ///
                                model.isShowStartedButton
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(AuthScreen());
                                          },
                                          child: Text(
                                            "Get started",
                                            style: buttonTextStyle.copyWith(
                                              color: Colors.black,
                                              // color: orangeColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            model.updatePageFromButton();
                                          },
                                          child: Text(
                                            "Next",
                                            style: buttonTextStyle.copyWith(
                                              color: blackColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                // ArrowButton(
                                //   onPressed: () {
                                //     if (model.currentPageIndex <
                                //         model.onboardingList.length - 1) {
                                //       model.updatePageFromButton();
                                //     } else {
                                //       Get.to(LoginScreen());
                                //     }
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
