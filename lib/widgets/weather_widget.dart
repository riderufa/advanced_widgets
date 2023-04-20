import 'package:flutter/material.dart';

class WeatherWidget extends CustomPainter {
  const WeatherWidget({required this.value});

  final double value;

  double _getDropsOpacity() {
    if (value < 0.7) {
      return 0;
    }
    return 10 / 3 * value - 7 / 3;
  }

  double _getCloudOpacity() {
    if (value < 0.5) {
      return 0;
    }
    return 2 * value - 1;
  }

  double _getSunOpacity() {
    return -1 * value + 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final sunPainter = Paint()
      ..color = Colors.yellow.withOpacity(_getSunOpacity())
      ..style = PaintingStyle.fill;

    final cloudPainter = Paint()
      ..color = Colors.black.withOpacity(_getCloudOpacity())
      ..style = PaintingStyle.fill;

    final dropPainter = Paint()
      ..color = Colors.blue.withOpacity(_getDropsOpacity())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final cloudPath = Path()
      ..moveTo(40, 70)
      ..relativeQuadraticBezierTo(-40, 0, -40, -15)
      ..relativeQuadraticBezierTo(0, -20, 25, -7)
      ..relativeQuadraticBezierTo(17, -25, 30, 0)
      ..relativeQuadraticBezierTo(20, -10, 25, 10)
      ..relativeQuadraticBezierTo(0, 15, -40, 12);

    final dropsPath = Path()
      ..moveTo(15, 75)
      ..lineTo(10, 85)
      ..moveTo(40, 75)
      ..lineTo(35, 85)
      ..moveTo(65, 75)
      ..lineTo(60, 85);

    canvas.drawCircle(const Offset(40, 40), 20, sunPainter);
    canvas.drawPath(cloudPath, cloudPainter);
    canvas.drawPath(dropsPath, dropPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
