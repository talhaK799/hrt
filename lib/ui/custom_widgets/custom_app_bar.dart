import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  final title;
  CustomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(
          isWhite: true,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 25),
          child: Text(
            title,
            style: subHeadingTextWhite.copyWith(
              color: blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
