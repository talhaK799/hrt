import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/style.dart';
import '../auth_screens/auth_screens.dart';

class InitialAgeScreen extends StatelessWidget {
  const InitialAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///
          /// Background Image
          ///
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                70,
                18,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    '$staticAsset/connection.png',
                  ),
                  sizeBox20,
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 40, right: 20, left: 20, top: 30),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "You must be 18 years or older to explore Hart. If you're not, goodbye for now.",
                            style: buttonTextStyle.copyWith(
                              color: blackColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  CustomButton(
                    title: "I'm 18+",
                    onTap: () {
                      Get.offAll(AuthScreen());
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
