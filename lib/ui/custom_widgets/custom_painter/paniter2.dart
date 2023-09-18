//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';

class Painter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height / 2);
    path_0.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height / 2,
    );
    path_0.quadraticBezierTo(
      size.width / 2,
      -size.height / 2,
      size.width / 2,
      size.height / 2,
    );

    Paint paint_0_fill = Paint()..style = PaintingStyle.stroke;
    paint_0_fill..strokeWidth = 8.0;
    paint_0_fill.color = blackColor;
    // .withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
