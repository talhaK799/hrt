import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/custom_text_field_2.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/email_screen.dart/email_verification_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailVerificationProvider(),
      child:
          Consumer<EmailVerificationProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 80,
              ),
              child: Column(
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
                          onChange: (val) {
                            model.email = val;
                          },
                          hintText: 'Email',
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Email Required';
                            } else {
                              // model.email = val;
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
                            FocusManager.instance.primaryFocus?.unfocus();
                            // model.sendotptoEmail();
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
            ),
          ),
        );
      }),
    );
  }
}
