//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4452715, size.height * 0.04970115);
    path_0.cubicTo(
        size.width * 0.3820000,
        size.height * 0.03527560,
        size.width * 0.3240672,
        size.height * 0.008645533,
        size.width * 0.2490148,
        size.height * 0.008645533);
    path_0.lineTo(size.width * 0.09946237, size.height * 0.008645533);
    path_0.cubicTo(
        size.width * 0.06383118,
        size.height * 0.008645533,
        size.width * 0.03494624,
        size.height * 0.01896753,
        size.width * 0.03494624,
        size.height * 0.03170029);
    path_0.lineTo(size.width * 0.03494624, size.height * 0.9769452);
    path_0.cubicTo(
        size.width * 0.03494624,
        size.height * 0.9896734,
        size.width * 0.06383118,
        size.height,
        size.width * 0.09946237,
        size.height);
    path_0.lineTo(size.width * 0.9005376, size.height);
    path_0.cubicTo(
        size.width * 0.9361694,
        size.height,
        size.width * 0.9650538,
        size.height * 0.9896734,
        size.width * 0.9650538,
        size.height * 0.9769452);
    path_0.lineTo(size.width * 0.9650538, size.height * 0.03170029);
    path_0.cubicTo(
        size.width * 0.9650538,
        size.height * 0.01896753,
        size.width * 0.9361694,
        size.height * 0.008645533,
        size.width * 0.9005376,
        size.height * 0.008645533);
    path_0.lineTo(size.width * 0.7617392, size.height * 0.008645533);
    path_0.cubicTo(
        size.width * 0.6866855,
        size.height * 0.008645533,
        size.width * 0.6287527,
        size.height * 0.03527560,
        size.width * 0.5654812,
        size.height * 0.04970115);
    path_0.cubicTo(
        size.width * 0.5477742,
        size.height * 0.05373823,
        size.width * 0.5272527,
        size.height * 0.05604640,
        size.width * 0.5053763,
        size.height * 0.05604640);
    path_0.cubicTo(
        size.width * 0.4835000,
        size.height * 0.05604640,
        size.width * 0.4629785,
        size.height * 0.05373823,
        size.width * 0.4452715,
        size.height * 0.04970115);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = blackColor;
    // .withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
