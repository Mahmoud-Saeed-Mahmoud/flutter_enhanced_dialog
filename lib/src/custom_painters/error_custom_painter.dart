import 'dart:math';

import 'package:flutter/material.dart';

class ErrorCustomPainter extends CustomPainter {
  final double progress;
  final Color color;

  ErrorCustomPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Draw the circle
    if (progress < 0.5) {
      final circleProgress = progress * 2;
      final sweepAngle = 2 * pi * circleProgress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        sweepAngle,
        false,
        paint,
      );
    } else {
      canvas.drawCircle(center, radius, paint);
    }

    // Draw the cross lines
    if (progress > 0.5) {
      final lineProgress = (progress - 0.5) * 2;

      // First line of the cross
      final startPoint1 = Offset(
        center.dx - radius * 0.6,
        center.dy - radius * 0.6,
      );
      final endPoint1 = Offset(
        center.dx + radius * 0.6,
        center.dy + radius * 0.6,
      );
      final currentEnd1 = Offset.lerp(
        startPoint1,
        endPoint1,
        lineProgress,
      )!;
      canvas.drawLine(startPoint1, currentEnd1, paint);

      // Second line of the cross
      if (progress > 0.75) {
        final lineProgress2 = (progress - 0.75) * 4;
        final startPoint2 = Offset(
          center.dx + radius * 0.6,
          center.dy - radius * 0.6,
        );
        final endPoint2 = Offset(
          center.dx - radius * 0.6,
          center.dy + radius * 0.6,
        );
        final currentEnd2 = Offset.lerp(
          startPoint2,
          endPoint2,
          lineProgress2,
        )!;
        canvas.drawLine(startPoint2, currentEnd2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ErrorCustomPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
