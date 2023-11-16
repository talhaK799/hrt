import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';
import 'package:hart/ui/screens/profile_screen/premium_setting/premium_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/style.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PremiumProvider(),
      child: Consumer<PremiumProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                60,
                24,
                40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(title: 'Premium membership'),
                  GestureDetector(
                    // behavior: HitTestBehavior.translucent,
                    // onTap: () {
                    //   Get.to(MaestroScreen());
                    // },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Incognito',
                          style: buttonTextStyle.copyWith(
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          activeColor: primaryColor,
                          value: model.x,
                          onChanged: (val) {
                            model.changeValue(val);
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Your Facebook friends won’t see you on Hart. You will be hidden from non-Facebook users until you like them.',
                    style: subtitleText.copyWith(
                      color: lightRed,
                    ),
                  ),
                  sizeBox20,
                  Text(
                    'Learn more about Incognito',
                    style: buttonTextStyleRed.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  sizeBox20,
                  _heading(
                    heading: 'Know when someone likes you',
                    body: 'See who likes you and make connections faster.',
                  ),
                  sizeBox30,
                  _heading(
                    heading: 'Private photos',
                    body:
                        'Don’t show your photos to strangers. Only your connections will see them.',
                  ),
                  sizeBox30,
                  _heading(
                    heading: 'Search by what you desire',
                    body:
                        'See only the people who are in tune with your desire.',
                  ),
                  sizeBox30,
                  Text(
                    'Included with premium',
                    style: subtitleText.copyWith(
                      color: lightRed,
                    ),
                  ),
                  sizeBox30,
                  _heading(
                    heading: 'Last seen',
                    body: 'See when a member was last active.',
                  ),
                  sizeBox30,
                  _heading(
                    heading: '1 Spank a day',
                    body:
                        'Notify a member you like immediately and increase your chances of connecting.',
                  ),
                  sizeBox30,
                  Text(
                    'Options',
                    style: subtitleText,
                  ),
                  sizeBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Purchase membership', style: bodyTextStyle),
                      Image.asset(
                        '$staticAsset/arrow.png',
                        scale: 3,
                      ),
                    ],
                  ),
                  sizeBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Restore membership', style: bodyTextStyle),
                      Image.asset(
                        '$staticAsset/arrow.png',
                        scale: 3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // _miniText({text}) {
  //   return Text(
  //     text,
  //     style: subtitleText.copyWith(
  //       color: lightRed,
  //     ),
  //   );
  // }

  _heading({heading, body}) {
    return GestureDetector(
      // behavior: HitTestBehavior.translucent,
      // onTap: () {
      //   Get.to(MaestroScreen());
      // },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                heading,
                style: bodyTextStyle.copyWith(
                  color: primaryColor,
                ),
              ),
              Image.asset(
                '$staticAsset/arrow.png',
                scale: 3,
                color: primaryColor,
              ),
            ],
          ),
          sizeBox10,
          Text(
            body,
            style: subtitleText.copyWith(
              color: lightRed,
            ),
          ),
        ],
      ),
    );
  }
}
