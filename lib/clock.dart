import 'dart:math';
import 'package:flutter/material.dart';

const fullCircle = 2 * pi;

class Clock extends CustomPainter {
  Clock({required this.timeNotifier}) : super(repaint: timeNotifier);

  final ValueNotifier<DateTime> timeNotifier;

  void _drawFrame(Canvas canvas, double radius) {
    final paint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset.zero,
      radius,
      paint,
    );
  }

  void _drawTicks(Canvas canvas, double radius) {
    final tickRadius = 5.0;
    final tickPaint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    canvas.save();

    final hoursSpawn = 12;
    final hoursAngle = fullCircle / hoursSpawn;

    for (var i = 0; i < hoursSpawn; i++) {
      if (i % 3 == 0) {
        canvas.drawCircle(
          Offset(0, -radius + 10),
          tickRadius,
          tickPaint,
        );
      } else {
        canvas.drawLine(
          Offset(0, -radius + 5),
          Offset(0, -radius + 10),
          tickPaint,
        );
      }

      canvas.rotate(hoursAngle);
    }

    canvas.restore();
  }

  void _drawHand(Canvas canvas, double angle, length, Paint paint) {
    canvas.save();
    canvas.rotate(angle);
    canvas.drawLine(
      Offset.zero,
      Offset(0, length),
      paint,
    );
    canvas.restore();
  }

  void _drawHands(Canvas canvas, double radius) {
    final time = timeNotifier.value;

    final hoursAngle =
        (((time.hour % 12) + (time.minute / 60)) / 12) * fullCircle;
    final minutesAngle = ((time.minute + (time.second / 60))) / 60 * fullCircle;

    // grand seiko spring drive
    // final secondsAngle =
    //     ((time.second + time.millisecond / 1000) / 60) * fullCircle;
    //
    // grand seiko hi beat 36000
    // final secondsAngle =
    //     ((time.second + ((time.millisecond ~/ 100) / 10)) / 60) * fullCircle;
    //
    // rolex eta 28800
    final secondsAngle =
        ((time.second + ((time.millisecond ~/ 125) / 8)) / 60) * fullCircle;

    final minutesPaint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = .stroke;

    final hoursPaint = Paint()
      ..strokeWidth = 3.0
      ..color = Colors.green
      ..style = .stroke;

    final secondsPaint = Paint()
      ..strokeWidth = 1.0
      ..color = Colors.white
      ..style = .stroke;

    final centralPaint = Paint()
      ..strokeWidth = 1.5
      ..color = Colors.cyanAccent;

    _drawHand(canvas, minutesAngle, -radius + 30, minutesPaint);
    _drawHand(canvas, hoursAngle, -radius + 50, hoursPaint);
    _drawHand(canvas, secondsAngle, -radius + 20, secondsPaint);

    canvas.drawCircle(Offset.zero, 2.0, centralPaint);
  }

  void _drawDialText(Canvas canvas, double radius) {
    final textSpan = TextSpan(
      text: 'ROLEX',
      style: TextStyle(
        color: Colors.white38,
        fontSize: 16.0,
        fontFamily: 'monospace',
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: .ltr,
      textAlign: .center,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -radius + 40));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final (x, y) = (size.width / 2, size.height / 2);
    final radius = y;

    canvas.translate(x, y);

    _drawFrame(canvas, radius);
    _drawTicks(canvas, radius);
    _drawHands(canvas, radius);
    _drawDialText(canvas, radius);
  }

  @override
  bool shouldRepaint(Clock oldDelegate) => true;
}
