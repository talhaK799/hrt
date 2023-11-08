import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WhiteHart10SecLoader2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/Hart White 10 sec.json',
        repeat: true,
        frameRate: FrameRate(
          100,
        ),
      ),
    );
  }
}
