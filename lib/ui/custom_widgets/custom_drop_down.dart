import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/style.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton({
    Key? key,
    required this.value,
    required this.onchange,
    required this.items,
    this.color,
  });

  final value;
  final onchange;
  final List<String> items;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      style: buttonTextStyle.copyWith(color: color ?? greyColor2),
      dropdownColor: whiteColor,
      value: value,
      icon: Icon(
        Icons.arrow_forward_ios,
        color: color ?? greyColor2,
        size: 15,
      ),
      onChanged: onchange,
      items: items
          .map(
            (val) => DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
              ),
            ),
          )
          .toList(),
    );
  }
}
