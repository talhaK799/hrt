import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:provider/provider.dart';
import 'notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: Consumer<NotificationProvider>(builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      isWhite: true,
                    ),
                    Image.asset(
                      '$staticAsset/bell.png',
                      scale: 3,
                    ),
                  ],
                ),
                sizeBox30,
                Text(
                  'Notification',
                  style: bodyTextStyle,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 95),
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 40.r,
                            backgroundImage: AssetImage(
                              '$dynamicAsset/profile.png',
                            ),
                          ),
                          title: Text(
                            'Laiba',
                            style: subHeadingTextStyle2.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          subtitle: Text(
                            'Lorem ipsum dolor sit amet consectetur. Ut Lorem ipsum venenatis magna ac senectus risus.',
                            style: subtitleText.copyWith(
                              color: greyColor2,
                            ),
                          ),
                          trailing: Text(
                            '12 : 03',
                            style: miniText.copyWith(
                              color: greyColor2,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // _groupNameTextField() {
  //   return CustomTextFieldWhite();
  // }
}
