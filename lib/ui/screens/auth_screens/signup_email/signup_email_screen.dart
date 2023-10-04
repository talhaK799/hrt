import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_text_feild.dart';
import 'package:hart/ui/screens/base_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';
import '../login/login_screen.dart';
import 'signup_email_provider.dart';

class SignUpWithEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpwithEmailProvider(),
      child:
          Consumer<SignUpwithEmailProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: BaseScreen(
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
                      Text('Sign Up', style: headingText),
                      Text('We’re happy to see you here.',
                          style: subHeadingTextStyle),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),

                  ///
                  /// TextFields
                  ///
                  Form(
                    key: model.formKey,
                    child: _textFields(model, context),
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Already have an account',
                  //       style: subHeadingTextStyle,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Get.to(
                  //           LoginScreen(),
                  //         );
                  //       },
                  //       child: Text(
                  //         'Login',
                  //         style: buttonTextStyle.copyWith(
                  //           decoration: TextDecoration.underline,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _textFields(SignUpwithEmailProvider model, BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          validator: (val) {
            if (val.isEmpty) {
              return 'User Name is Required';
            } else {
              model.appuser.name = val;
              return null;
            }
          },
          onChange: (val) {
            // model.appuser.name = val;
          },
          hintText: 'Name',
          prefixIcon: 'user.png',
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextField(
          validator: (val) {
            if (val.isEmpty) {
              return 'Email is Required';
            } else {
              model.appuser.email = val;
              return null;
            }
          },
          onChange: (val) {
            // model.appuser.email = val;
            // log('onchange ${val}');
          },
          hintText: 'Email',
          prefixIcon: 'email.png',
          // controller: model.emailController,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          validator: (val) {
            if (val.isEmpty) {
              return 'Password is Required';
            } else {
              return null;
            }
          },
          onChange: (val) {
            // model.appuser.email = val;
            // log('onchange ${val}');
          },
          hintText: 'Password',
          prefixIcon: 'password.png',
          controller: model.passwordController,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          validator: (val) {
            if (val.isEmpty) {
              return 'Password is Required';
            } else if (model.passwordController.text !=
                model.confirmPasswordController.text) {
              return 'Password donot Match';
            } else {
              model.appuser.password = val;
              return null;
            }
          },
          onChange: (val) {
            // model.appuser.email = val;
            // log('onchange ${val}');
          },
          hintText: 'Confirm Password',
          prefixIcon: 'password.png',
          controller: model.confirmPasswordController,
        ),
        SizedBox(
          height: 40.h,
        ),

        ///
        ///Sign Up BUTTON
        ///
        CustomButton(
          title: 'Sign Up',
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            model.signUp(context);
            // if (model.formKey.currentState!.validate()) {
            //   model.signUp(context);
            // }
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
                'Already have an account? ',
                style: subHeadingTextStyle.copyWith(
                  color: blackColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    LoginScreen(),
                  );
                },
                child: Text(
                  'Login',
                  style: subHeadingTextStyle.copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
