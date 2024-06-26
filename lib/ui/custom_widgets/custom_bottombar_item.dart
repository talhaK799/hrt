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
  double? size;
  CustomBottomBarItem({
    required this.icon,
    required this.icon2,
    required this.currentIndex,
    required this.activeIndex,
    this.size,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: currentIndex == activeIndex
            ? ImageIcon(
                AssetImage(
                  '$staticAsset/$icon2',
                ),
                size: size ?? 20,
                color: primaryColor,
              )
            : ImageIcon(
                AssetImage(
                  '$staticAsset/$icon',
                ),
                color: greyColor2,
                size: size ?? 20,
              ),
      ),
    );
  }
}
