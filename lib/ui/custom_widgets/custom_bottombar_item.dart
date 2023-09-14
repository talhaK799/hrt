import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

// ignore: must_be_immutable
class CustomBottomBarItem extends StatelessWidget {
  VoidCallback onTap;
  String icon;
  String icon2;
  int currentIndex;
  int activeIndex;
  CustomBottomBarItem({
    required this.icon,
    required this.icon2,
    required this.currentIndex,
    required this.activeIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: currentIndex == activeIndex
          ? ImageIcon(
            AssetImage(
              '$staticAsset/$icon2',
            ),
            size: 30,
            color: primaryColor,
          )
          : ImageIcon(
              AssetImage(
                '$staticAsset/$icon',
              ),
              size: 30,
            ),
    );
  }
}