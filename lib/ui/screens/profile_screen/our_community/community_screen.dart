import 'package:flutter/material.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';

import '../../../custom_widgets/custom_list_item.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: 'Our community'),
            sizeBox30,
            ListView(
              shrinkWrap: true,
              children: [
                CustomListItem(
                  text: 'Community Guideline',
                ),
                sizeBox20,
                CustomListItem(
                  text: 'Hart Journal',
                ),
                sizeBox20,
                CustomListItem(
                  text: 'Events',
                ),
                sizeBox20,
                CustomListItem(
                  text: 'Share Hart',
                ),
                sizeBox20,
              ],
            )
          ],
        ),
      ),
    );
  }

  // _groupNameTextField() {
  //   return CustomTextFieldWhite();
  // }
}


