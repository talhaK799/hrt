import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/auth_screens/auth_provider.dart';
import 'package:hart/ui/screens/auth_screens/login/login_screen.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/phone_login_screen.dart';
import 'package:hart/ui/screens/auth_screens/signup_email/signup_email_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../custom_widgets/right_navigation.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
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
                        onTap: () {
                          model.signInWithGoogle(context);
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomButton(
                        icon: 'Facebook.png',
                        title: 'Sign Up With Facebook',
                        onTap: () {
                          model.signInWithFacebook(context);
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomButton(
                        icon: 'Apple Icon.png',
                        title: 'Sign Up With Apple',
                        onTap: () {
                          model.loginWithApple(context);
                        },
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
                            // Get.to(
                            //   PhoneLoginScreen(),
                            // );
                            Navigator.push(
                  context,
                  PageFromRight(
                    page: PhoneLoginScreen(),
                  ),
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
                                // Get.to(LoginScreen());
                                Navigator.push(
                  context,
                  PageFromRight(
                    page: LoginScreen(),
                  ),
                );
                              },
                              child: Text(
                                'Login',
                                style: subHeadingTextStyle.copyWith(
                                    color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
