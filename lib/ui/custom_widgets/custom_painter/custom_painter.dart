//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';
import 'package:hart/core/constants/colors.dart';

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.2908333, size.height * 0.9985714);
    path_0.lineTo(size.width * 0.3741667, size.height * 0.9271429);
    path_0.lineTo(size.width * 0.4566667, size.height * 0.8585714);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.8271429);
    path_0.lineTo(size.width * 0.5408333, size.height * 0.8557143);
    path_0.lineTo(size.width * 0.6241667, size.height * 0.9285714);
    path_0.lineTo(size.width * 0.7083333, size.height * 0.9985714);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);

    canvas.drawPath(path_0, paint_fill_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
