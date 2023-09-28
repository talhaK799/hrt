import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_text_field_2.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/email_verification_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';
import 'code_confirmation_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailVerificationProvider>(builder: (context, model, child) {
        return Scaffold(
    body: Padding(
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify your Email',
                style: headingText.copyWith(
                  color: blackColor,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Form(
                key: model.formKey,
                child: Column(
                  children: [
                    CustomTextField2(
                      onChange: (val) {},
                      hintText: 'Email',
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Email Required';
                        } else {
                          model.email = val;
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      title: 'CONTINUE',
                      onTap: () {
                        if (model.formKey.currentState!.validate()) {
                          model.sendotptoEmail();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    ),
        );
      });
  }
}
