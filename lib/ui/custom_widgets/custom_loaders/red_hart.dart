import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RedHartLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/hart_red.json',
        repeat: true,
        frameRate: FrameRate(
          100,
        ),
      ),
    );
  }
}
