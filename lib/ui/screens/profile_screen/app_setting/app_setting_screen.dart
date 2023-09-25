import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/style.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Show distance in miles',
                style: bodyTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: bodyTextStyle,
                  ),
                  Switch(
                    activeColor: blackColor,
                    value: true,
                    onChanged: (val) {
                      // model.recent(val);
                    },
                  ),
                ],
              ),
              sizeBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Great for low light conditions and lover of the night.',
                      style: subtitleText.copyWith(
                        color: greyColor2,
                      ),
                    ),
                  ),
                  Switch(
                    activeColor: greyColor2,
                    thumbColor: MaterialStatePropertyAll(blackColor),
                    value: true,
                    onChanged: (val) {
                      // model.recent(val);
                    },
                  ),
                ],
              ),
              sizeBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'App icon',
                    style: bodyTextStyle,
                  ),
                  Text(
                    'Hart Dark red',
                    style: subtitleText.copyWith(
                      color: greyColor2,
                    ),
                  ),
                ],
              ),
              sizeBox30,
              Text(
                'Your login methods',
                style: subtitleText.copyWith(
                  color: greyColor2,
                ),
              ),
              sizeBox20,
              _heading(heading: 'Email', body: 'Add email'),
              sizeBox20,
              _heading(heading: 'Facebook', body: 'Linked'),
              sizeBox30,
              Text(
                'Your account',
                style: subtitleText.copyWith(
                  color: greyColor2,
                ),
              ),
              sizeBox20,
              GestureDetector(
                child: Text(
                  'Notifications',
                  style: bodyTextStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ),
              sizeBox20,
              GestureDetector(
                child: Text(
                  'Deactivate',
                  style: bodyTextStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ),
              sizeBox20,
              GestureDetector(
                child: Text(
                  'Terminate',
                  style: bodyTextStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ),
              sizeBox20,
            ],
          ),
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
      ],
    );
  }
}
