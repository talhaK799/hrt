import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/strings.dart';

class BaseScreen extends StatelessWidget {
  final body;
  const BaseScreen({
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            child: SvgPicture.asset(
              '$staticAsset/background.svg',
              fit: BoxFit.fill,
            ),
          ),
          body,
        ],
      ),
    ));
  }
}
