import 'dart:math';

import 'package:flutter/material.dart';

class SuccessCustomPainter extends CustomPainter {
  final Color color;
  final double circleProgress;
  final double checkProgress;

  SuccessCustomPainter({
    required this.color,
    required this.circleProgress,
    required this.checkProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1;

    final Paint checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round;

    // Draw circle
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * 0.4;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi / 2,
      2 * pi * circleProgress,
      false,
      circlePaint,
    );

    // Draw checkmark
    if (checkProgress > 0) {
      final Path checkPath = Path();
      final double baseX = size.width * 0.25;
      final double baseY = size.height * 0.5;

      checkPath.moveTo(baseX, baseY);

      final double firstLineEndX = size.width * 0.45;
      final double firstLineEndY = size.height * 0.65;

      final double secondLineEndX = size.width * 0.75;
      final double secondLineEndY = size.height * 0.35;

      // Calculate intermediate points for animation
      if (checkProgress <= 0.5) {
        // Animate first line
        final double progress = checkProgress * 2;
        final double currentX = baseX + (firstLineEndX - baseX) * progress;
        final double currentY = baseY + (firstLineEndY - baseY) * progress;
        checkPath.lineTo(currentX, currentY);
      } else {
        // Draw complete first line and animate second line
        checkPath.lineTo(firstLineEndX, firstLineEndY);
        final double progress = (checkProgress - 0.5) * 2;
        final double currentX =
            firstLineEndX + (secondLineEndX - firstLineEndX) * progress;
        final double currentY =
            firstLineEndY + (secondLineEndY - firstLineEndY) * progress;
        checkPath.lineTo(currentX, currentY);
      }

      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SuccessCustomPainter oldDelegate) {
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.checkProgress != checkProgress ||
        oldDelegate.color != color;
  }
}
