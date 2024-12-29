import 'dart:math' as math;

import 'package:flutter/material.dart';

class WarningCustomPainter extends CustomPainter {
  final Color color;
  final double circleProgress;
  final double exclamationProgress;

  WarningCustomPainter({
    required this.color,
    required this.circleProgress,
    required this.exclamationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;

    final Paint exclamationPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * 0.4;

    // Draw circle
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -math.pi / 2,
      2 * math.pi * circleProgress,
      false,
      circlePaint,
    );

    if (exclamationProgress > 0) {
      // Draw exclamation mark body
      final double exclamationHeight = size.height * 0.35;
      final double exclamationWidth = size.width * 0.08;
      final double topY = size.height * 0.25;

      final RRect exclamationBody = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, topY + (exclamationHeight * 0.4)),
          width: exclamationWidth,
          height: exclamationHeight * exclamationProgress,
        ),
        Radius.circular(exclamationWidth / 2),
      );

      canvas.drawRRect(exclamationBody, exclamationPaint);

      // Draw exclamation mark dot
      if (exclamationProgress > 0.8) {
        final double dotProgress = (exclamationProgress - 0.8) * 5;
        final double dotSize = exclamationWidth;
        final double dotY = topY + exclamationHeight + dotSize;

        canvas.drawCircle(
          Offset(centerX, dotY),
          (dotSize / 2) * dotProgress,
          exclamationPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant WarningCustomPainter oldDelegate) {
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.exclamationProgress != exclamationProgress ||
        oldDelegate.color != color;
  }
}
