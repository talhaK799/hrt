import 'package:flutter/material.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_app_bar.dart';
import 'package:hart/ui/custom_widgets/custom_list_item.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: 'Help'),
            sizeBox30,
            ListView(
              shrinkWrap: true,
              children: [
                CustomListItem(
                  text: 'Contact support',
                ),
                sizeBox20,
                CustomListItem(
                  text: 'Help center',
                ),
                sizeBox20,
                CustomListItem(
                  text: 'FAQ',
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
