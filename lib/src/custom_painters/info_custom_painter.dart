import 'dart:math';

import 'package:flutter/material.dart';

class InfoCustomPainter extends CustomPainter {
  final double circleProgress;
  final double dotProgress;
  final double lineProgress;
  final double rippleProgress;
  final Color color;

  InfoCustomPainter({
    required this.circleProgress,
    required this.dotProgress,
    required this.lineProgress,
    required this.rippleProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Paint for ripple effect
    final ripplePaint = Paint()
      ..color = color.withValues(
        alpha: (1 - rippleProgress) * 0.3,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04;

    // Draw ripple effect
    canvas.drawCircle(
      center,
      radius * rippleProgress * 1.5,
      ripplePaint,
    );

    // Paint for main circle
    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw main circle with progress
    if (circleProgress > 0) {
      final circlePath = Path()
        ..addArc(
          Rect.fromCircle(center: center, radius: radius),
          -pi / 2,
          2 * pi * circleProgress,
        );
      canvas.drawPath(circlePath, circlePaint);
    }

    // Paint for dot and line
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw dot
    if (dotProgress > 0) {
      canvas.drawCircle(
        Offset(center.dx, center.dy - radius * 0.3),
        radius * 0.12 * dotProgress,
        dotPaint,
      );
    }

    // Draw line
    if (lineProgress > 0) {
      final linePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.2
        ..strokeCap = StrokeCap.round;

      final linePath = Path();
      final startY = center.dy - radius * 0.1;
      final endY = center.dy + radius * 0.3;

      linePath.moveTo(center.dx, startY);
      linePath.lineTo(
        center.dx,
        startY + (endY - startY) * lineProgress,
      );

      canvas.drawPath(linePath, linePaint);
    }

    // Add shine effect
    if (circleProgress > 0.8) {
      final shinePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final shineOffset = Offset(size.width * 0.2, size.height * 0.2);
      canvas.drawArc(
        Rect.fromCircle(center: shineOffset, radius: radius * 0.3),
        -pi / 4,
        pi / 2,
        false,
        shinePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant InfoCustomPainter oldDelegate) {
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.dotProgress != dotProgress ||
        oldDelegate.lineProgress != lineProgress ||
        oldDelegate.rippleProgress != rippleProgress ||
        oldDelegate.color != color;
  }
}
