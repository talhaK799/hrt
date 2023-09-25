import 'package:flutter/material.dart';
import 'package:hart/core/constants/strings.dart';

import '../../core/constants/style.dart';

class CustomListItem extends StatelessWidget {
  final text;
  const CustomListItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: bodyTextStyle),
        Image.asset(
          '$staticAsset/arrow.png',
          scale: 3,
        ),
      ],
    );
  }
}