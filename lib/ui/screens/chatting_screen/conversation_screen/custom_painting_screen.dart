import 'package:flutter/material.dart';
import 'package:hart/core/others/screen_utils.dart';
import 'package:hart/ui/custom_widgets/custom_painter/paniter2.dart';

class CustomPaintingScreen extends StatelessWidget {
  const CustomPaintingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: Painter2(),
        child: Container(
          width: 1.sw,
          height: 1.sh,
        ),
      ),
    );
  }
}
