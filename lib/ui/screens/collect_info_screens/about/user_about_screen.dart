import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/screens/collect_info_screens/about/user_about_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/style.dart';

class UserAboutScreen extends StatelessWidget {
  final bool isUpdate;
  UserAboutScreen({this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutProvider(isUpdate),
      child: Consumer<AboutProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
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
                            'Write about yourself',
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
                                  value: 8,
                                ),
                          SizedBox(
                            height: 40.h,
                          ),
                          TextFormField(
                            maxLines: 7,
                            initialValue: model.currentUser.appUser.about,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "About Required";
                              } else {
                                model.about = val;
                                return null;
                              }
                            },
                            onChanged: (val) {
                              model.about = val.trim();
                            },
                            cursorColor: primaryColor,
                            style: subHeadingTextStyle.copyWith(
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.zero,
                              hintText: "I am .....",
                              hintStyle: subHeadingTextStyle.copyWith(
                                color: greyColor,
                              ),
                              errorStyle: subHeadingTextStyle.copyWith(
                                color: primaryColor,
                              ),
                              // suffix: suffex,
                              // border: InputBorder,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomButton(
                        title: 'CONTINUE',
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (model.formKey.currentState!.validate()) {
                            model.saveAbout(context);
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
        },
      ),
    );
  }
}
