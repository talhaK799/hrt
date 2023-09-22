import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/screens/collect_info_screens/exploring_together/explor_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class FantasiesScreen extends StatelessWidget {
  const FantasiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FantasiesProvider(),
      child: Consumer<FantasiesProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          
          inAsyncCall: model.state==ViewState.busy,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 40,
                right: 50,
                top: 50,
              ),
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
                        'What are your desire & fantasies.',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomProgressIndicator(
                        value: 5,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Selected tags will appear publicaly  on  your  profile. You can edit them in setting.',
                        style: descriptionTextStyle.copyWith(
                          color: blackColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Selected ${model.selections}',
                          style: descriptionTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ListView.separated(
                        itemCount: model.items.length,
                        shrinkWrap: true,
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
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    title: 'CONTINUE',
                    onTap: () {
                      Get.to(
                        ExploreScreen(),
                      );
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
