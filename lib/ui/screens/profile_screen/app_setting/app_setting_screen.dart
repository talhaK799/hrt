import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/screens/auth_screens/auth_screens.dart';
import 'package:hart/ui/screens/profile_screen/Notifications/notification_screen.dart';
import 'package:hart/ui/screens/profile_screen/app_setting/app_setting_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/style.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppSettingProvider(),
      child: Consumer<AppSettingProvider>(builder: (context, model, child) {
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
                  CustomAppBar(title: 'App Setting'),
                  sizeBox30,
                  // Text(
                  //   'Show distance in miles',
                  //   style: bodyTextStyle,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: bodyTextStyle,
                      ),
                      Switch(
                        activeColor: blackColor,
                        value: model.isNotificationsOn,
                        onChanged: (val) {
                          model.changeNotificaionSettin(val);
                        },
                      ),
                    ],
                  ),
                  // sizeBox20,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         'Great for low light conditions and lover of the night.',
                  //         style: subtitleText.copyWith(
                  //           color: greyColor2,
                  //         ),
                  //       ),
                  //     ),
                  //     Switch(
                  //       activeColor: greyColor2,
                  //       thumbColor: MaterialStatePropertyAll(blackColor),
                  //       value: true,
                  //       onChanged: (val) {
                  //         // model.recent(val);
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // sizeBox20,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'App icon',
                  //       style: bodyTextStyle,
                  //     ),
                  //     Text(
                  //       'Hart Dark red',
                  //       style: subtitleText.copyWith(
                  //         color: greyColor2,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  sizeBox30,
                  Text(
                    'Your login methods',
                    style: subtitleText.copyWith(
                      color: greyColor2,
                    ),
                  ),
                  sizeBox20,
                  _heading(
                      heading: 'Phone Number',
                      body: model.auth.appUser.isPhoneNoVerified == true
                          ? 'Linked'
                          : 'Add Phone number'),
                  sizeBox20,
                  _heading(
                      heading: 'Facebook',
                      body: model.auth.appUser.isFacebook == true
                          ? 'Linked'
                          : 'Link Facebook'),
                  sizeBox20,
                  _heading(
                      heading: 'Google',
                      body: model.auth.appUser.isGoogle == true
                          ? 'Linked'
                          : 'Link Google'),
                  sizeBox30,
                  Text(
                    'Your account',
                    style: subtitleText.copyWith(
                      color: greyColor2,
                    ),
                  ),
                  sizeBox20,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        NotificationScreen(),
                      );
                    },
                    child: Text(
                      'Notifications',
                      style: bodyTextStyle.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  // sizeBox20,
                  // GestureDetector(
                  //   child: Text(
                  //     'Deactivate',
                  //     style: bodyTextStyle.copyWith(
                  //       color: primaryColor,
                  //     ),
                  //   ),
                  // ),
                  sizeBox20,
                  GestureDetector(
                    onTap: () {
                      model.terminateUser(context);
                    },
                    child: Text(
                      'Delete Account',
                      style: bodyTextStyle.copyWith(
                          color: primaryColor, fontSize: 14.sp),
                    ),
                  ),
                  sizeBox20,
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
      onTap: () {
        Get.to(
          AuthScreen(),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: bodyTextStyle.copyWith(
              color: blackColor,
            ),
          ),
          Row(
            children: [
              Text(
                body,
                style: subtitleText.copyWith(
                  color: greyColor2,
                ),
              ),
              sizeBoxw10,
              Image.asset(
                '$staticAsset/arrow.png',
                scale: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
