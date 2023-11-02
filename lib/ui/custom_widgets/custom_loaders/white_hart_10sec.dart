import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WhiteHart10SecLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/hart_white_10sec.json',
        repeat: true,
        frameRate: FrameRate(
          100,
        ),
      ),
    );
  }
}
