import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/enums/view_state.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/custom_widgets/custom_loader.dart';
import 'package:hart/ui/screens/auth_screens/firebase_phone_login/phone_login_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/style.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneLoginProvider>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: CustomLoader(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              top: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login with your phone number',
                        style: headingText.copyWith(
                          color: blackColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),

                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 1.sw,
                            height: 65.h,
                            decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius: BorderRadius.circular(32.r),
                                border: Border.all(color: pinkColor2)),
                          ),
                          phoneNoTextFeild(model),
                        ],
                      )
                      // CustomTextField2(
                      //     onChange: (val) {},
                      //     hintText: 'Example: +3933144….',
                      //     validator: (val) {}),
                    ],
                  ),
                ),
                // Spacer(),
                CustomButton(
                  title: 'CONTINUE',
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (model.formKey.currentState!.validate()) {
                      model.sentOTP(context);
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
    });
  }

  phoneNoTextFeild(PhoneLoginProvider model) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              // keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              style: subHeadingTextStyle.copyWith(
                color: primaryColor,
              ),
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "",
                prefixIcon: CountryCodePicker(
                  padding: EdgeInsets.only(right: 0, left: 0),
                  showDropDownButton: true,
                  // hideMainText: true,
                  textStyle: subHeadingTextStyle.copyWith(
                    color: primaryColor,
                  ),
                  showFlag: false,

                  initialSelection: model.initialCountry,

                  onChanged: (value) {
                    model.selectCountryCode(
                      value.dialCode,
                    );
                  },

                  comparator: (a, b) => model.compareCountries(a, b),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 2,
            color: Colors.grey,
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
              onChanged: (val) {
                print('value $val');
                model.appUser.phoneNumber = val;
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return 'phone no required';
                } else {
                  // model.appUser.phoneNumber = val;
                  return null;
                }
              },
              // controller: controller,
              cursorColor: primaryColor,
              style: subHeadingTextStyle.copyWith(
                color: primaryColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                hintText: '348----',
                hintStyle: subHeadingTextStyle.copyWith(
                  color: greyColor,
                ),
                errorStyle: subHeadingTextStyle.copyWith(
                  color: primaryColor,
                ),
                // suffix: suffex,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
