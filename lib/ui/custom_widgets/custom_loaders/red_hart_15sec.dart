import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RedHart15SecLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/Hart Red 15 sec.json',
        repeat: true,
        frameRate: FrameRate(
          100,
        ),
      ),
    );
  }
}
