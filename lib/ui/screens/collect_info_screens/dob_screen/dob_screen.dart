import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/custom_progress_indicator.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_provider.dart';
import 'package:hart/ui/screens/collect_info_screens/nick_name/nick_name_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/style.dart';

class DOBScreen extends StatelessWidget {
  bool isUpdate;
  DOBScreen({
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DobProvider(isUpdate),
      child: Consumer<DobProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 50,
                right: 50,
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
                        'Add date of birth',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomProgressIndicator(
                        value: 1,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomButton(
                        title: model.pickedDate == null
                            ? 'Example: 12/03/1985'
                            : monthNameDate.format(model.pickedDate!),
                        color: pinkColor,
                        textColor:
                            model.pickedDate == null ? greyColor : primaryColor,
                        onTap: () {
                          model.pickDate(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200.h,
                  ),
                  CustomButton(
                    title: 'CONTINUE',
                    onTap: () {
                      model.addDob();
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
