import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/collect_info_screens/permissions/permission_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';
import 'add_photo_provider.dart';

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPhotoProvider(),
      child: Consumer<AddPhotoProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
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
                        'Add your photos',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomProgressIndicator(
                        value: 7,
                      ),
                    ],
                  ),
                  GridView.builder(
                      itemCount: 9,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            model.pickImge();
                          },
                          child: Container(
                            width: 90.w,
                            height: 90.h,
                            decoration: BoxDecoration(
                              color: greyColor,
                              image: model.image != null
                                  ? DecorationImage(
                                      image: FileImage(model.image!),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius: BorderRadius.circular(
                                12.r,
                              ),
                            ),
                            child: model.image == null
                                ? Center(
                                    child: Image.asset(
                                    '$staticAsset/Add.png',
                                    scale: 3,
                                  ))
                                : null,
                          ),
                        );
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    title: 'CONTINUE',
                    onTap: () {
                      Get.to(
                        PermissionScreen(),
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
