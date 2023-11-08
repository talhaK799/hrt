import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WhiteHart15SecLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/Hart White 15 sec.json',
        repeat: true,
        frameRate: FrameRate(
          100,
        ),
      ),
    );
  }
}
