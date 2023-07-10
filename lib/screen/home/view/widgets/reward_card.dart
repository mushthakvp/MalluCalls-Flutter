import 'package:flutter/material.dart';

class AtmCard extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff7949e1).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                0, 0, size.width * 0.9992690, size.height * 0.9986772),
            bottomRight: Radius.circular(size.width * 0.01461988),
            bottomLeft: Radius.circular(size.width * 0.01461988),
            topLeft: Radius.circular(size.width * 0.01461988),
            topRight: Radius.circular(size.width * 0.01461988)),
        paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4842018, size.height * 0.9991614);
    path_1.lineTo(size.width * 0.01461988, size.height * 0.9991614);
    path_1.cubicTo(size.width * 0.006545526, size.height * 0.9991614, 0,
        size.height * 0.9873175, 0, size.height * 0.9727063);
    path_1.lineTo(0, size.height * 0.4947090);
    path_1.cubicTo(
        size.width * 0.06151849,
        size.height * 0.4955807,
        size.width * 0.1324079,
        size.height * 0.5186349,
        size.width * 0.2046038,
        size.height * 0.5655198);
    path_1.cubicTo(
        size.width * 0.3604678,
        size.height * 0.6667407,
        size.width * 0.4726031,
        size.height * 0.8466825,
        size.width * 0.4842018,
        size.height * 0.9991614);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xFFFFFFFF).withOpacity(0.05);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.9992982, size.height * 0.3407328);
    path_2.cubicTo(
        size.width * 0.9728363,
        size.height * 0.3297341,
        size.width * 0.9457456,
        size.height * 0.3154233,
        size.width * 0.9184795,
        size.height * 0.2977116);
    path_2.cubicTo(
        size.width * 0.8074635,
        size.height * 0.2256204,
        size.width * 0.7186367,
        size.height * 0.1135947,
        size.width * 0.6725146,
        0);
    path_2.lineTo(size.width * 0.9846784, 0);
    path_2.cubicTo(
        size.width * 0.9927558,
        0,
        size.width * 0.9992982,
        size.height * 0.01184433,
        size.width * 0.9992982,
        size.height * 0.02645503);
    path_2.lineTo(size.width * 0.9992982, size.height * 0.3407328);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xFFFFFFFF).withOpacity(0.05);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
