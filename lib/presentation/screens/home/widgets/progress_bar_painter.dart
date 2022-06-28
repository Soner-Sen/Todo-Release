import 'package:flutter/material.dart';

class ProgressBarPainter extends CustomPainter {
  //Aktuelle Breite vom Widget
  double parentWidth;
  double barHeight;

  double donePercent;

  Color backgroundColor;
  Color percentageColor;

  ProgressBarPainter(
      {required this.donePercent,
      required this.parentWidth,
      required this.barHeight,
      required this.backgroundColor,
      required this.percentageColor});

  //Einen Stift simuliert
  getPaint(Color color) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultBarPaint = getPaint(backgroundColor);
    Paint percentageBarPaint = getPaint(percentageColor);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(-(parentWidth / 2), -(barHeight / 2)) &
                Size(parentWidth, barHeight),
            Radius.circular(barHeight)),
        defaultBarPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(-(parentWidth / 2), -(barHeight / 2)) &
                Size(parentWidth * donePercent, barHeight),
            Radius.circular(barHeight)),
        percentageBarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
