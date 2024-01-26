import 'package:csc_picker_i18n/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';
import 'package:hart/ui/custom_widgets/custom_button.dart';
import 'package:hart/ui/screens/home/home_provider.dart';
import 'package:provider/provider.dart';

class CountrySelectionScren extends StatelessWidget {
  // Variables to store country, state, and city data in onChanged method.

  @override
  Widget build(BuildContext context) {
    String countryValue = "Country";

    String cityValue = "City";
    // TextEditingController country = TextEditingController();
    // TextEditingController state = TextEditingController();
    // TextEditingController city = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomBackButton(
                        isWhite: true,
                      ),
                      30.horizontalSpace,
                      Text(
                        'Select Location',
                        style: headingText.copyWith(
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),

                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Location',
                        style: buttonTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: greyColor.withOpacity(0.1),
                            disabledColor: redColor),
                        child: Switch(
                          activeColor: primaryColor,
                          value: model.isCurrent,
                          trackOutlineWidth: MaterialStateProperty.all(10),
                          onChanged: (val) {
                            model.current(val);
                          },
                        ),
                      ),
                    ],
                  ),

                  30.verticalSpace,

                  ///Widget initialize
                  model.isCurrent
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CSCPicker(
                              onCountryChanged: (value) {
                                countryValue = value ?? "";
                              },
                              onStateChanged: (value) {
                                cityValue = value ?? "";
                              },
                              onCityChanged: (value) {},
                              showCities: false,
                              stateDropdownLabel: 'City',
                            ),
                            // CountryStateCityPicker(
                            //   country: country,
                            //   state: state,
                            //   city: city,
                            //   dialogColor: Colors.grey.shade200,
                            //   textFieldDecoration: InputDecoration(
                            //     fillColor: whiteColor,
                            //     filled: true,
                            //     suffixIcon:
                            //         const Icon(Icons.arrow_downward_rounded),
                            //     border: const OutlineInputBorder(
                            //         borderSide: BorderSide.none),
                            //   ),
                            // ),
                            50.verticalSpace,
                            CustomButton(
                                title: 'Continue',
                                onTap: () {
                                  print(
                                      'country ==> ${countryValue} and city==> ${cityValue}');
                                  Navigator.pop(context, [
                                    countryValue,
                                    cityValue,
                                  ]);
                                }),
                          ],
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
