import 'dart:math';

import 'package:flutter/material.dart';

/// A custom painter that draws an animated success checkmark with a circular progress indicator
///
/// This painter draws two main components:
/// 1. A circular progress indicator that animates clockwise
/// 2. A checkmark that animates in two parts - first the diagonal line, then the vertical line
///
/// The animation is controlled by two progress values:
/// - [circleProgress]: Controls the circular progress (0.0 to 1.0)
/// - [checkProgress]: Controls the checkmark drawing (0.0 to 1.0)
class SuccessCustomPainter extends CustomPainter {
  /// The color used for both the circle and checkmark
  final Color color;

  /// Progress value for the circular animation (0.0 to 1.0)
  final double circleProgress;

  /// Progress value for the checkmark animation (0.0 to 1.0)
  /// - 0.0 to 0.5: Animates the first diagonal line
  /// - 0.5 to 1.0: Animates the second vertical line
  final double checkProgress;

  /// Creates a [SuccessCustomPainter] with the specified parameters
  ///
  /// All parameters are required:
  /// - [color]: Defines the color of both the circle and checkmark
  /// - [circleProgress]: Controls the circular progress animation (0.0 to 1.0)
  /// - [checkProgress]: Controls the checkmark animation (0.0 to 1.0)
  SuccessCustomPainter({
    required this.color,
    required this.circleProgress,
    required this.checkProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Configure paint settings for the circular progress indicator
    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1;

    // Configure paint settings for the checkmark
    final Paint checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round; // Rounds the ends of the lines

    // Calculate circle dimensions
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * 0.4;

    // Draw the circular progress indicator
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi / 2, // Start from the top (12 o'clock position)
      2 * pi * circleProgress, // Draw the arc based on progress
      false, // Don't include radius lines to center
      circlePaint,
    );

    // Draw the animated checkmark when progress starts
    if (checkProgress > 0) {
      final Path checkPath = Path();

      // Define checkmark starting point (left point)
      final double baseX = size.width * 0.25;
      final double baseY = size.height * 0.5;

      // Define endpoints for both lines of the checkmark
      final double firstLineEndX = size.width * 0.45;
      final double firstLineEndY = size.height * 0.65;
      final double secondLineEndX = size.width * 0.75;
      final double secondLineEndY = size.height * 0.35;

      checkPath.moveTo(baseX, baseY);

      // Animate the checkmark in two phases
      if (checkProgress <= 0.5) {
        // Phase 1: Animate the first diagonal line (0.0 to 0.5)
        final double progress = checkProgress * 2;
        final double currentX = baseX + (firstLineEndX - baseX) * progress;
        final double currentY = baseY + (firstLineEndY - baseY) * progress;
        checkPath.lineTo(currentX, currentY);
      } else {
        // Phase 2: Complete first line and animate second line (0.5 to 1.0)
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
    // Repaint when any of the animation progress values or color changes
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.checkProgress != checkProgress ||
        oldDelegate.color != color;
  }
}
