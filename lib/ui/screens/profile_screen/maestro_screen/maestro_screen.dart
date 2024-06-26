import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/models/subscripton.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loaders/red_hart_10sec.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_painter/custom_painter.dart';

class MaestroScreen extends StatelessWidget {
  const MaestroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MaestroProvider(),
        child: Consumer<MaestroProvider>(builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            progressIndicator: RedHart10SecLoader(),
            child: Scaffold(
              backgroundColor: primaryColor,
              body: Stack(
                children: [
                  ///
                  /// Background Image
                  ///
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 0.35.sh,
                        // ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1,
                          child: SvgPicture.asset(
                            '$staticAsset/circle.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      18,
                      45,
                      18,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomBackButton(isWhite: false),
                            sizeBoxw10,
                            Text(
                              'Become Maestro',
                              style: subHeadingTextWhite,
                            ),
                          ],
                        ),
                        sizeBox20,
                        Container(
                            child: CarouselSlider.builder(
                                itemCount: model.sliderImages.length,
                                itemBuilder: (context, index, realIndex) =>
                                    Container(
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              model.sliderImages[index].image!,
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                options: CarouselOptions(
                                  height: 350,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.5,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    model.changeDot(index);
                                  },
                                ))),
                        sizeBox10,
                        Center(
                          child: DotsIndicator(
                            dotsCount: model.sliderImages.length,
                            position: model.dotIndicator,
                            decorator: DotsDecorator(
                                color: pinkColor2,
                                activeColor: primaryColor,
                                size: Size(7, 7),
                                spacing: EdgeInsets.only(right: 5)),
                          ),
                        ),
                        sizeBox20,
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Center(
                                child: Text(
                                  model.sliderImages[model.dotIndicator].title!,
                                  style: subHeadingText1.copyWith(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              sizeBox10,
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  model.sliderImages[model.dotIndicator]
                                      .description!,
                                  textAlign: TextAlign.center,
                                  style: buttonTextStyle.copyWith(
                                    color: greyColor2,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              sizeBox20,
                              for (int i = 0;
                                  i < model.subscriptions.length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    model.selectPlan(i);
                                  },
                                  child: priceTable(model.subscriptions[i], i),
                                ),
                              sizeBox30,
                              CustomButton(
                                title: 'BECOME A MAESTRO',
                                onTap: () {
                                  print(
                                      'payment id => ${model.auth.appUser.paymentId}=======user ID ==> ${model.auth.appUser.id}');
                                  if (model.auth.appUser.paymentId == null) {
                                    model.makePayment(context);
                                  } else {
                                    Get.snackbar("Alert!!",
                                        "You have already subscription");
                                  }
                                },
                              ),
                              sizeBox20,
                              CustomButton(
                                title: 'Skip',
                                color: pinkColor,
                                textColor: primaryColor,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              sizeBox20,
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  priceTable(Subscription subscription, index) {
    return Container(
      // color: pinkColor,
      padding: EdgeInsets.only(
        left: 24,
        top: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: subscription.isSelected == true ? pinkColor : whiteColor,
        borderRadius: index == 0
            ? BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              )
            : null,
        border: Border.all(color: pinkColor2, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '€ ${subscription.price}',
            style: bodyTextStyle.copyWith(
              color: primaryColor,
            ),
          ),
          Column(
            children: [
              Text(
                index == 2
                    ? "${subscription.no_days} months"
                    : "${subscription.no_days} days",
                style: bodyTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
              Text(
                subscription.weeklyPrice!,
                style: buttonTextStyleGrey.copyWith(
                  color: lightRed,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
