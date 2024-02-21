import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/custom_loaders/red_hart_10sec.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';
import 'add_photo_provider.dart';

class AddPhotoScreen extends StatelessWidget {
  bool isUpdate;
  AddPhotoScreen({this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPhotoProvider(isUpdate),
      child: Consumer<AddPhotoProvider>(
        builder: (context, model, child) {
          return BlurryModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            opacity: 0.4,
            color: Colors.black,
            blurEffectIntensity: 4,
            progressIndicator: RedHart10SecLoader(),
            child: Scaffold(
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
                          primary: false,
                          itemCount:
                              // model.isMultipleSelection
                              //     ? model.imageFileList!.length
                              //     :
                              model.images.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return _userImage(model, index);
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomButton(
                        title: 'Add Photos',
                        onTap: () {
                          model.selectMultipleImages();
                        },
                        color: pinkColor,
                        textColor: primaryColor,
                      ),
                      sizeBox20,
                      CustomButton(
                        title: 'CONTINUE',
                        onTap: () {
                          model.addUserImages();
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

  _userImage(AddPhotoProvider model, int index) {
    return GestureDetector(
      onTap: () => model.pickImge(),
      child: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: greyColor,
          image: model.images[index].image != null
              ? DecorationImage(
                  image: FileImage(
                    model.images[index].image!,
                  ),
                  fit: BoxFit.cover,
                )
              : model.images[index].imgUrl != null
                  ? DecorationImage(
                      image:
                          NetworkImage(model.images[index].imgUrl!.toString()),
                      fit: BoxFit.cover,
                    )
                  : null,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        child: model.images[index].image == null &&
                model.images[index].imgUrl == null
            ? Center(
                child: Image.asset(
                '$staticAsset/Add.png',
                scale: 3,
              ))
            : GestureDetector(
                onTap: () {
                  model.removeImage(index);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    '$staticAsset/remove.png',
                    scale: 4,
                  ),
                ),
              ),
      ),
    );
  }
}
