import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/custom_widgets/dialogs/custom_snackbar.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class SelectGenderScreen extends StatelessWidget {
  bool isFileter;
  bool isUpdate;
  SelectGenderScreen({
    this.isFileter = false,
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectGenderProvider(isFileter, isUpdate),
      child: Consumer<SelectGenderProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          // progressIndicator: CustomLoader(),
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 40,
                right: 50,
                top: 50,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isFileter || isUpdate
                          ? CustomBackButton(
                              isWhite: true,
                            )
                          : Container(),

                      ///
                      /// Back Button
                      ///
                      // GestureDetector(
                      //   behavior: HitTestBehavior.opaque,
                      //   onTap: () {
                      //   },
                      //   child: Image.asset(
                      //     '$staticAsset/back2.png',
                      //     scale: 2.8,
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'What are you looking for?',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      isFileter || isUpdate
                          ? Container()
                          : CustomProgressIndicator(
                              value: 4,
                            ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: model.items.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 100),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomButton(
                              title: model.items[index].title!,
                              onTap: () {
                                model.select(index);
                              },
                              color: model.items[index].isSelected == true
                                  ? primaryColor
                                  : pinkColor,
                              textColor: model.items[index].isSelected == true
                                  ? whiteColor
                                  : primaryColor,
                            );
                          },
                          separatorBuilder: (context, index) => sizeBox20,
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomButton(
                        title: 'CONTINUE',
                        onTap: () {
                          if (isFileter) {
                            print(
                                'selected item==> ${model.selections.length}');
                            // Get.back(result: model.selections);
                            Navigator.pop(context, model.selections);
                          } else {
                            model.addSelectedItems(context);
                          }
                        },
                      ),
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
