import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/phone_login_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneLoginProvider>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: CustomLoader(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 35,
              right: 35,
              top: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Conformation Code',
                      style: headingText.copyWith(
                        color: blackColor,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Please enter 6-digit code sent to your Phone No.',
                      style: subHeadingTextStyle.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Pinput(
                      length: 6,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      onChanged: (val) {
                        model.phoneOtp = val;
                      },
                      defaultPinTheme: PinTheme(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: greyColor,
                          //     offset: const Offset(
                          //       5.0,
                          //       5.0,
                          //     ),
                          //     blurRadius: 10.0,
                          //     spreadRadius: 2.0,
                          //   )
                          // ],
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(
                            4.r,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                RichText(
                  text: TextSpan(
                    text: 'You can request code again in ',
                    style: descriptionTextStyle.copyWith(
                        color: blackColor, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: '30s',
                        style: descriptionTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomButton(
                  title: 'CONTINUE',
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    model.verifyPhoneOtp();
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
