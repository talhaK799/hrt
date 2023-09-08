import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/strings.dart';

// ignore: must_be_immutable
class BaseScreen extends StatelessWidget {
  final body;
  String? image;
  bool? isLight;
  Color? backgroundColor;
  BaseScreen({
    required this.body,
    this.isLight = false,
    this.image,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            child: !isLight!
                ? SvgPicture.asset(
                    image??'$staticAsset/background.svg',
                    fit: BoxFit.fill,
                  )
                : SvgPicture.asset(
                    image??'$staticAsset/Elipse2.svg',
                    fit: BoxFit.fill,
                  ),
          ),
          body,
        ],
      ),
    ));
  }
}
