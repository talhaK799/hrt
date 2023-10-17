import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/collect_info_screens/permissions/permission_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermissionProvider(),
      child: Consumer<PermissionProvider>(builder: (context, model, child) {
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
                CustomBackButton(
                  isWhite: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Permissions',
                  style: headingText.copyWith(
                    color: blackColor,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomProgressIndicator(
                  value: 8,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'A few things we need your permission to access before you begin:',
                  style: descriptionTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      '$staticAsset/notification.png',
                      scale: 3,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      'Notifications',
                      style: headingText.copyWith(
                        fontSize: 18.sp,
                        color: blackColor,
                      ),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 16.h,
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    'We notify you when you have a new connection or receive a message.',
                    style: descriptionTextStyle.copyWith(
                      color: greyColor2,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      '$staticAsset/location.png',
                      scale: 3,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      'Location',
                      style: headingText.copyWith(
                        fontSize: 18.sp,
                        color: blackColor,
                      ),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 16.h,
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    'We connect you with  the other  Hart  members based on your location.',
                    style: descriptionTextStyle.copyWith(
                      color: greyColor2,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(
                  title: 'FIX',
                  onTap: () {
                    model.getPermissions();
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
