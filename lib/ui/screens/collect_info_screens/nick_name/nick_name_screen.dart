import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/custom_widgets/custom_text_field_2.dart';
import 'package:hart/ui/screens/collect_info_screens/idetity_screen/identity_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/nick_name/nick_name_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class NickNameScreen extends StatelessWidget {
  const NickNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NickNameProvider(),
      child: Consumer<NickNameProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state==ViewState.busy,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 40,
                right: 50,
                top: 50,
              ),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          isWhite: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Choose your nickname',
                          style: headingText.copyWith(
                            color: blackColor,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomProgressIndicator(
                          value: 2,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomTextField2(
                          onChange: (val) {},
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Nick Name Required";
                            } else {
                              model.currentUser.appUser.nickName = val;
                              return null;
                            }
                          },
                          hintText: 'Example: James',
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                      title: 'CONTINUE',
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (model.formKey.currentState!.validate()) {
                          model.addNickName();
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
