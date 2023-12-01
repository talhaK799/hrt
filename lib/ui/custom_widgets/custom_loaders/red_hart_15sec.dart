import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RedHart15SecLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: Lottie.asset(
          'assets/animations/new-animation.json',
          repeat: true,
          frameRate: FrameRate.max,
        ),
      ),
    );
  }
}
