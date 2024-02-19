import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/custom_widgets/custom_text_field_2.dart';
import 'package:hart/ui/screens/collect_info_screens/name/name_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/style.dart';

class NameScreen extends StatelessWidget {
  final bool isUpdate;
  NameScreen({this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NameProvider(isUpdate),
      child: Consumer<NameProvider>(builder: (context, model, child) {
        return Scaffold(
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
                      CustomBackButton(isWhite: true),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Enter your name',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      isUpdate
                          ? Container()
                          : CustomProgressIndicator(
                              value: 2,
                            ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomTextField2(
                        onChange: (val) {},
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Name Required";
                          } else {
                            model.name = val;
                            return null;
                          }
                        },
                        hintText: 'Example: James Dan',
                        formatter: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'\s')), // Deny spaces
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    title: 'CONTINUE',
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (model.formKey.currentState!.validate()) {
                        model.addName(context);
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
        );
      }),
    );
  }
}
