import 'package:flutter/material.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_text_feild.dart';
import 'package:hart/ui/screens/auth_screens/forgot_password/phone_no_verification/phone_no_verification_provider.dart';
import 'package:hart/ui/screens/base_screen.dart';
import 'package:provider/provider.dart';

class PhoneNoVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhoneNoVerificationProvider(),
      child: Consumer<PhoneNoVerificationProvider>(builder: (context, model, child) {
        return BaseScreen(
          isLight: true,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Image.asset(
                    '$logoPath/logo3.png',
                    scale: 3,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Text('Forgot password', style: headingText),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                        'Reset password instruction will be send to the provided email address.',
                        style: subHeadingTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),

                ///
                /// TextFields
                ///
                Form(
                  key: model.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Phone No Required';
                          } else {
                            // model.appuser.email = val;
                            return null;
                          }
                        },
                        onChange: (val) {
                          // model.appuser.email = val;
                          // log('onchange ${val}');
                        },
                        hintText: 'Phone No',
                        prefixIcon: 'email.png',
                        // controller: model.emailController,
                      ),
                      SizedBox(
                        height: 100.h,
                      ),

                      ///
                      ///Sign Up BUTTON
                      ///
                      CustomButton(
                        title: 'Login',
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (model.formkey.currentState!.validate()) {
                            // model.signUp();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
