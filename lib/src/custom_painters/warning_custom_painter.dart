import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A custom painter that draws an animated warning icon consisting of a circle and an exclamation mark.
///
/// The warning icon is composed of two main elements:
/// 1. A circular outline that can be animated using [circleProgress]
/// 2. An exclamation mark that can be animated using [exclamationProgress]
///
/// The animation can be controlled by providing values between 0.0 and 1.0 for both
/// [circleProgress] and [exclamationProgress].
class WarningCustomPainter extends CustomPainter {
  /// The color used to paint both the circle and exclamation mark
  final Color color;

  /// Controls the progress of the circle animation (0.0 to 1.0)
  /// - 0.0: Circle is not drawn
  /// - 1.0: Complete circle is drawn
  final double circleProgress;

  /// Controls the progress of the exclamation mark animation (0.0 to 1.0)
  /// - 0.0: Exclamation mark is not drawn
  /// - 0.0-0.8: Only the vertical line is drawn (proportional to value)
  /// - 0.8-1.0: Dot appears and grows
  final double exclamationProgress;

  /// Creates a WarningCustomPainter with the specified parameters
  WarningCustomPainter({
    required this.color,
    required this.circleProgress,
    required this.exclamationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Configure paint settings for the circle outline
    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;

    // Configure paint settings for the exclamation mark
    final Paint exclamationPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Calculate center coordinates and radius for the circle
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * 0.4;

    // Draw the circular outline with animation progress
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -math.pi / 2, // Start from top (12 o'clock position)
      2 * math.pi * circleProgress, // Draw arc based on progress
      false,
      circlePaint,
    );

    // Only draw exclamation mark if progress is greater than 0
    if (exclamationProgress > 0) {
      // Calculate dimensions for exclamation mark
      final double exclamationHeight = size.height * 0.35;
      final double exclamationWidth = size.width * 0.08;
      final double topY = size.height * 0.25;

      // Draw the vertical line of exclamation mark with rounded corners
      final RRect exclamationBody = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, topY + (exclamationHeight * 0.4)),
          width: exclamationWidth,
          height: exclamationHeight * exclamationProgress,
        ),
        Radius.circular(exclamationWidth / 2),
      );
      canvas.drawRRect(exclamationBody, exclamationPaint);

      // Draw the dot of exclamation mark when progress is > 80%
      if (exclamationProgress > 0.8) {
        final double dotProgress =
            (exclamationProgress - 0.8) * 5; // Scale 0.8-1.0 to 0.0-1.0
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
    // Repaint only if any of the properties have changed
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.exclamationProgress != exclamationProgress ||
        oldDelegate.color != color;
  }
}
