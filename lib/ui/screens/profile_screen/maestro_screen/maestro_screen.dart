import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_provider.dart';
import 'package:provider/provider.dart';

class MaestroScreen extends StatelessWidget {
  const MaestroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MaestroProvider(),
        child: Consumer<MaestroProvider>(builder: (context, model, child) {
          return Scaffold(
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
                      SizedBox(
                        height: 0.35.sh,
                      ),
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

                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      18,
                      50,
                      18,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Become Majesic',
                          style: subHeadingTextWhite,
                        ),
                        sizeBox20,
                        Center(
                          child: Image.asset(
                            '$dynamicAsset/maestro.png',
                            scale: 4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        sizeBox10,
                        Center(
                          child: DotsIndicator(
                            dotsCount: 6,
                            decorator: DotsDecorator(
                                color: pinkColor2,
                                activeColor: primaryColor,
                                size: Size(7, 7),
                                spacing: EdgeInsets.only(right: 5)),
                          ),
                        ),
                        sizeBox20,
                        Center(
                          child: Text(
                            'Unlimited Likes',
                            style: subHeadingText1.copyWith(
                              color: blackColor,
                            ),
                          ),
                        ),
                        sizeBox10,
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            'You’re close to meeting your people. Speed things up with Majestic Maestro',
                            textAlign: TextAlign.center,
                            style: buttonTextStyle.copyWith(
                              color: greyColor2,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        sizeBox20,
// BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(16.r),
//                               topRight: Radius.circular(16.r),
//                             ),
//                             border: Border.all(color: pinkColor2, width: 1.5),
//                           ),
                        priceTable(),

                        sizeBox30,
                        CustomButton(
                          title: 'BECOME A MAESTRO',
                          onTap: () {},
                        ),
                        sizeBox20,
                        CustomButton(
                          title: 'Skip',
                          color: pinkColor,
                          textColor: primaryColor,
                          onTap: () {},
                        ),
                        sizeBox20,
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }

  priceTable() {
    return Column(
      children: [
        Container(
          // color: pinkColor,
          padding: EdgeInsets.only(
            left: 24,
            top: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: pinkColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            border: Border.all(color: pinkColor2, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$25',
                style: bodyTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
              Column(
                children: [
                  Text(
                    '30 days',
                    style: bodyTextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    '(6.20 per week)',
                    style: buttonTextStyleGrey.copyWith(
                      color: lightRed,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          // color: pinkColor,
          padding: EdgeInsets.only(
            left: 24,
            top: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: pinkColor2, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$59',
                style: bodyTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
              Column(
                children: [
                  Text(
                    '90 days',
                    style: bodyTextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    '(4.20 per week)',
                    style: buttonTextStyleGrey.copyWith(
                      color: lightRed,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          // color: pinkColor,
          padding: EdgeInsets.only(
            left: 24,
            top: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: pinkColor2, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$160',
                style: bodyTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
              Column(
                children: [
                  Text(
                    '1 year',
                    style: bodyTextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    '(3.20 per week)',
                    style: buttonTextStyleGrey.copyWith(
                      color: lightRed,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
