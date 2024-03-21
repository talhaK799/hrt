import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/hart_red.json',
        repeat: true,
        frameRate: FrameRate(100),
      ),
    );
  }
}

class CustomLoaderWhite extends StatelessWidget {
  const CustomLoaderWhite({
    super.key,
  });

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
