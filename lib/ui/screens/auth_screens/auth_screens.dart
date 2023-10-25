import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/auth_screens/login/login_screen.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/phone_login_screen.dart';
import 'package:hart/ui/screens/auth_screens/signup_email/signup_email_screen.dart';

import '../../../core/constants/colors.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 70),
                  child: Image.asset(
                    '$logoPath/logo4.png',
                    scale: 3.7,
                  ),
                ),
                // SizedBox(
                //   height: 25.h,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Match, Meet & Enjoy',
                    style: headingText.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                CustomButton(
                  icon: 'Google Icon.png',
                  title: 'Sign Up With Google',
                  onTap: () {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomButton(
                  icon: 'Facebook.png',
                  title: 'Sign Up With Facebook',
                  onTap: () {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomButton(
                  icon: 'Apple Icon.png',
                  title: 'Sign Up With Apple',
                  onTap: () {},
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: greyColor,
                        thickness: 1.5,
                        endIndent: 20,
                      ),
                    ),
                    Text('Or sign up with'),
                    Expanded(
                      child: Divider(
                        color: greyColor,
                        thickness: 1.5,
                        indent: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                // CustomButton(
                //     title: 'Sign Up With Email',
                //     onTap: () {
                //       Get.to(SignUpWithEmail());
                //     }),
                // SizedBox(
                //   height: 20.h,
                // ),
                CustomButton(
                    title: 'Sign Up With Telephone Phone number',
                    onTap: () {
                      Get.to(
                        PhoneLoginScreen(),
                      );
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: subHeadingTextStyle.copyWith(
                          color: blackColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          'Login',
                          style:
                              subHeadingTextStyle.copyWith(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
