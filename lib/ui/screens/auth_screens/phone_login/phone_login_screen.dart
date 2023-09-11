import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_text_feild.dart';
import 'package:hart/ui/screens/auth_screens/forgot_password/phone_no_verification/phone_no_verification.dart';
import 'package:hart/ui/screens/auth_screens/phone_login/phone_login_provider.dart';
import 'package:hart/ui/screens/auth_screens/signup_email/signup_email_screen.dart';
import 'package:hart/ui/screens/base_screen.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';

class PhoneLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhoneLoginProvider(),
      child: Consumer<PhoneLoginProvider>(builder: (context, model, child) {
        return BaseScreen(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      child: Text(
                        'Welcome back!',
                        style: headingText.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    Text('Lovely to see you again!',
                        style: subHeadingTextStyle),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),

                Text(
                  'Login',
                  style: headingText,
                ),
                SizedBox(
                  height: 40.h,
                ),

                ///
                /// TextFields
                ///
                Form(
                  key: model.fmkey,
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
                        prefixIcon: 'Phone Icon.png',
                        // controller: model.emailController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Password Required';
                          } else {
                            // model.appuser.email = val;
                            return null;
                          }
                        },
                        onChange: (val) {
                          // model.appuser.email = val;
                          // log('onchange ${val}');
                        },
                        hintText: 'Password',
                        prefixIcon: 'password.png',
                        // controller: model.passwordController,
                      ),

                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(
                              PhoneNoVerificationScreen(),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: buttonTextStyle,
                          )),
                      SizedBox(
                        height: 40.h,
                      ),

                      ///
                      ///Sign Up BUTTON
                      ///
                      CustomButton(
                        title: 'Login',
                        onTap: () {
                          if (model.fmkey.currentState!.validate()) {
                            // model.signUp();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: subHeadingTextStyle.copyWith(
                                color: blackColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  SignUpWithEmail(),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: subHeadingTextStyle.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account',
                      style: subHeadingTextStyle,
                    ),
                    TextButton(
                        onPressed: () {
                          // Get.to(LoginScreen());
                        },
                        child: Text(
                          'Login',
                          style: buttonTextStyle.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}