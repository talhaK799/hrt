import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/format_date.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/custom_widgets/custom_profile_tile.dart';
import 'package:hart/ui/custom_widgets/white_textfield.dart';
import 'package:hart/ui/screens/collect_info_screens/add_photo/add_photo_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/dob_screen/dob_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/fantasies_screen/fantasies_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/idetity_screen/identity_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/nick_name/nick_name_screen.dart';
import 'package:hart/ui/screens/collect_info_screens/select_gender_screen/select_gender_screen.dart';
import 'package:hart/ui/screens/profile_screen/edit_profile/edit_profile_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileProvider(),
      child: Consumer<EditProfileProvider>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: CustomLoader(),
          child: Scaffold(
              backgroundColor: primaryColor,
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 50, 32, 16),
                    child: CustomBackButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 105),
                    child: SingleChildScrollView(
                      child: Container(
                        width: 1.sw,
                        // padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(16.r),
                            right: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            ///
                            ///Profile Image
                            ///
                            Container(
                              width: 1.sw,
                              height: 0.45.sh,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                image: model.currentUser.appUser.images!.isEmpty
                                    ? DecorationImage(
                                        image: AssetImage(
                                            '$dynamicAsset/image.png'),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                          model.currentUser.appUser.images!
                                              .first,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            sizeBox10,
                            Form(
                              key: model.formKey,
                              child: _textFeilds(model, context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }

  _textFeilds(EditProfileProvider model, context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.to(
                AddPhotoScreen(),
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit photos',
                    style: subHeadingTextStyle2,
                  ),
                  Image.asset(
                    '$staticAsset/arrow.png',
                    scale: 3,
                    color: blackColor,
                  ),
                ],
              ),
            ),
          ),
          sizeBox20,
          heading('Nick Name'),
          CustomProfileTile(
            title: model.currentUser.appUser.nickName,
            textColor: greyColor2,
            iconColor: greyColor2,
            onTap: () {
              model.changeNickName();
            },
          ),

          sizeBox20,
          ////
          /// dob
          ///
          heading('Date of Birth'),

          CustomProfileTile(
            title: model.currentUser.appUser.dob,
            textColor: greyColor2,
            iconColor: greyColor2,
            onTap: () {
              // model.pickDate(context);
              Get.to(
                DOBScreen(),
              );
            },
          ),

          sizeBox20,
          heading('Sexuality'),

          CustomProfileTile(
            title: model.currentUser.appUser.identity,
            textColor: greyColor2,
            iconColor: greyColor2,
            onTap: () {
              model.changeSexuality();
            },
          ),

          sizeBox20,
          heading('Desire'),

          CustomProfileTile(
            title: model.currentUser.appUser.desire!.first,
            textColor: greyColor2,
            iconColor: greyColor2,
            onTap: () {
              model.changeDesires();
            },
          ),
          // CustomTextFieldWhite(
          //   validator: (val) {
          //     if (val.isEmpty) {
          //       return 'Field Required';
          //     } else {
          //       return null;
          //     }
          //   },
          //   onChange: (val) {
          //     model.desire = val;
          //   },
          //   hintText: model.currentUser.appUser.desire!.first,
          // ),
          sizeBox20,
          heading('Looking For'),

          CustomProfileTile(
            title: model.currentUser.appUser.lookingFor,
            textColor: greyColor2,
            iconColor: greyColor2,
            onTap: () {
              model.changeLookingFor();
            },
          ),

          ///
          /// Bio
          ///
          // _bioTextArea(),

          sizeBox30,
          Text('Private settings', style: buttonTextStyle2),
          sizeBox30,
          heading('Show me on Hart'),

          Text(
            'You are currently visible in Discover',
            style: buttonTextStyle2.copyWith(
              color: greyColor2,
            ),
          ),
          sizeBox20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Incognito',
                style: bodyTextStyle.copyWith(
                  color: lightRed,
                ),
              ),
              Switch(
                activeColor: lightRed,
                value: model.isIncoginito,
                onChanged: (val) {
                  model.incognito(val);
                },
              ),
            ],
          ),
          Text(
            'Your Facebook friends won’t see you on Hart. You will be hidden from non-Facebook users until you like them.',
            style: buttonTextStyle2.copyWith(
              color: lightRed,
            ),
          ),
          // sizeBox20,
          // CustomButton(
          //     title: 'Update Profile',
          //     onTap: () {
          //       if (model.formKey.currentState!.validate()) {
          //         model.updateProfile();
          //       }
          //     }),
        ],
      ),
    );
  }

  _bioTextArea() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: 1.sw,
          height: 130.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: greyColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 10),
          child: TextFormField(
            maxLines: 5,
            // obscureText: obscure ?? false,
            obscuringCharacter: '*',
            cursorColor: greyColor,
            style: subHeadingTextStyle.copyWith(
              color: blackColor,
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Share something about yourself...',
                hintStyle: subHeadingTextStyle.copyWith(
                  color: greyColor2,
                ),
                errorStyle: subHeadingTextStyle,
                // suffix: suffex,
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  heading(title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subHeadingTextStyle2,
        ),
        sizeBox10,
      ],
    );
  }
}
