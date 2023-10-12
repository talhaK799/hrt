import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';

class ConnectPopupScreen extends StatelessWidget {
  const ConnectPopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                200,
                18,
                0,
              ),
              child: SizedBox(
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 220.w,
                      height: 220.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: whiteColor,
                          width: 3,
                        ),
                        image: DecorationImage(
                            image: AssetImage(
                              "$dynamicAsset/image.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    sizeBox20,
                    Text(
                      'Congratulation! \nHere your connection!',
                      textAlign: TextAlign.center,
                      style: subHeadingText1.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    sizeBox10,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, right: 30),
                      child: Text(
                        'Say hello now to your \nnew connection!',
                        textAlign: TextAlign.center,
                        style: buttonTextStyle.copyWith(
                          color: greyColor2,
                        ),
                      ),
                    ),
                    sizeBox30,
                    CustomButton(
                      title: 'Say“Hello!”',
                      onTap: () {},
                    ),
                    sizeBox20,
                    CustomButton(
                      color: pinkColor,
                      textColor: primaryColor,
                      title: 'Back',
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
