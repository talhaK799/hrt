import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/profile_screen/uplift_screen/uplift_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/style.dart';

class UpliftScreen extends StatelessWidget {
  const UpliftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpliftPorvider(),
      child: Consumer<UpliftPorvider>(builder: (context, model, child) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAppBar(title: 'Uplift'),
                  sizeBox30,
                  Image.asset('$staticAsset/uplift_i.png'),
                  // SvgPicture.asset(
                  //   '$staticAsset/phone.svg',
                  // ),
                  sizeBox20,
                  Text(
                    'Let us uplift you',
                    style: subHeadingText1,
                  ),
                  sizeBox10,
                  Text(
                    'For 24 hours your profile will show up earlier for members in your area. Increasing you chances of making connections by 7 to 15 times.',
                    textAlign: TextAlign.center,
                    style: descriptionTextStyle.copyWith(
                      color: lightRed,
                    ),
                  ),
                  sizeBox20,
                  Text(
                    'Don’t worry no other members will ever know you have used this feature.',
                    textAlign: TextAlign.center,
                    style: descriptionTextStyle.copyWith(
                      color: lightRed,
                    ),
                  ),
                  sizeBox20,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 50,
                    ),
                    decoration: BoxDecoration(
                        color: pinkColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: pinkColor2,
                        )),
                    child: Text(
                      'Show up earlier to other members in your area for 24 hours for an increasing chances of making connections.',
                      style: subtitleText.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  sizeBox20,
                  CustomButton(
                      title: 'CONTINUE',
                      onTap: () {
                        model.upliftProfile();
                      }),
                  sizeBox20,
                  Text(
                    'Your profile will be uplifted immediately after your purchase is confirmed.',
                    style: descriptionTextStyle.copyWith(
                      color: primaryColor,
                    ),
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
