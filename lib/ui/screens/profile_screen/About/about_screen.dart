import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/profile_screen/About/privacy_screen.dart';
import 'package:hart/ui/screens/profile_screen/About/trems_conditions_screen.dart';

import '../../../custom_widgets/custom_list_item.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: 'About'),
              sizeBox30,
              ListView(
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: PrivacyPolicyScreen()));
                    },
                    child: CustomListItem(
                      text: 'Privacy policy',
                    ),
                  ),
                  sizeBox20,
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                          context, PageFromRight(page: TermsAndConditions()));
                    },
                    child: CustomListItem(
                      text: 'Term of service',
                    ),
                  ),
                  sizeBox20,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // _groupNameTextField() {
  //   return CustomTextFieldWhite();
  // }
}
