import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/strings.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/white_textfield.dart';
import 'package:hart/ui/screens/profile_screen/edit_profile/edit_profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileProvider(),
      child: Consumer<EditProfileProvider>(builder: (context, model, child) {
        return Scaffold(
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
                              image: DecorationImage(
                                image: AssetImage('$dynamicAsset/image.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          sizeBox20,
                          _textFeilds(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      }),
    );
  }

  _textFeilds() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit photos',
                style: subHeadingTextStyle2,
              ),
              Image.asset(
                '$staticAsset/arrow.png',
                scale: 3,
              ),
            ],
          ),
          sizeBox20,
          heading('Name'),
          CustomTextFieldWhite(
            hintText: 'Andreo',
          ),
          sizeBox20,
          heading('Date of Birth'),
          CustomTextFieldWhite(
            hintText: 'xx/yy/zz',
          ),
          sizeBox20,
          heading('Gender'),
          CustomTextFieldWhite(
            hintText: 'Male',
          ),
          sizeBox20,
          heading('Sexuality'),
          CustomTextFieldWhite(
            hintText: 'Straight',
          ),
          sizeBox20,
          heading('Desire'),
          CustomTextFieldWhite(
            hintText: 'Friendship',
          ),
          sizeBox20,
          heading('Interests'),
          CustomTextFieldWhite(
            hintText: 'Art, music, hiking',
          ),
          sizeBox20,
          heading('Bio'),

          ///
          /// Bio
          ///
          _bioTextArea(),

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
                'Notifications',
                style: bodyTextStyle.copyWith(
                  color: lightRed,
                ),
              ),
              Switch(
                activeColor: lightRed,
                value: true,
                onChanged: (val) {
                  // model.recent(val);
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
            style: subHeadingTextStyle,
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
