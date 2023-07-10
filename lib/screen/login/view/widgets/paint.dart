import 'package:flutter/material.dart';

class LoginPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(0, size.height * 0.8355913);
    path_0.cubicTo(
        size.width * 0.1039153,
        size.height * 0.8760481,
        size.width * 0.2119587,
        size.height * 0.9273606,
        size.width * 0.3120287,
        size.height * 0.9806995);
    path_0.cubicTo(
        size.width * 0.3299490,
        size.height * 0.9671803,
        size.width * 0.3493233,
        size.height * 0.9608149,
        size.width * 0.3649467,
        size.height * 0.9650986);
    path_0.cubicTo(
        size.width * 0.3775433,
        size.height * 0.9685529,
        size.width * 0.3855800,
        size.height * 0.9783462,
        size.width * 0.3887167,
        size.height * 0.9918029);
    path_0.cubicTo(
        size.width * 0.5647933,
        size.height * 0.8708966,
        size.width * 0.7401667,
        size.height * 0.7572115,
        size.width * 0.8166667,
        size.height * 0.7572115);
    path_0.cubicTo(
        size.width * 0.8974533,
        size.height * 0.7572115,
        size.width * 0.8460967,
        size.height * 0.8771803,
        size.width * 0.7651833,
        size.height * 0.9978678);
    path_0.cubicTo(
        size.width * 0.8368767,
        size.height * 0.9946490,
        size.width * 0.9282067,
        size.height * 0.9872163,
        size.width * 0.9449233,
        size.height * 0.9593486);
    path_0.cubicTo(
        size.width * 0.9588533,
        size.height * 0.9361250,
        size.width * 0.9786533,
        size.height * 0.9171274,
        size.width,
        size.height * 0.9046250);
    path_0.lineTo(size.width, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
