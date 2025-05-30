import 'dart:math';

import 'package:flutter/material.dart';

/// A custom painter that draws an animated information icon with various effects.
///
/// This painter creates an information icon with the following animated components:
/// - A circular background that fills in with [color]
/// - A ripple effect that expands outward
/// - A dot and line that form the "i" shape in white
/// - A shine effect that appears when the circle is nearly complete
///
/// The animation progress of each component is controlled separately through
/// progress parameters that range from 0.0 to 1.0.
class InfoCustomPainter extends CustomPainter {
  /// Progress of the main circle fill animation (0.0 to 1.0)
  final double circleProgress;

  /// Progress of the dot appearance animation (0.0 to 1.0)
  final double dotProgress;

  /// Progress of the vertical line drawing animation (0.0 to 1.0)
  final double lineProgress;

  /// Progress of the ripple effect animation (0.0 to 1.0)
  final double rippleProgress;

  /// The color used for the main circle and ripple effect
  final Color color;

  /// Creates an InfoCustomPainter with the specified animation progress values.
  ///
  /// All progress parameters must be between 0.0 and 1.0.
  InfoCustomPainter({
    required this.circleProgress,
    required this.dotProgress,
    required this.lineProgress,
    required this.rippleProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate common measurements used throughout the painting
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4; // Base radius for the icon

    // Draw expanding ripple effect
    // The ripple is a circular stroke that fades out as it expands
    final ripplePaint = Paint()
      ..color = color.withValues(
        alpha: (1 - rippleProgress) * 0.3, // Fade out as it expands
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04;

    canvas.drawCircle(
      center,
      radius * rippleProgress * 1.5, // Expand to 1.5x the base radius
      ripplePaint,
    );

    // Draw main circle background with fill animation
    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    if (circleProgress > 0) {
      // Create an arc path that fills clockwise from the top
      final circlePath = Path()
        ..addArc(
          Rect.fromCircle(center: center, radius: radius),
          -pi / 2, // Start from top (negative pi/2)
          2 * pi * circleProgress, // Sweep angle based on progress
        );
      canvas.drawPath(circlePath, circlePaint);
    }

    // Configure paint for white elements (dot and line)
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the dot (top of the "i")
    if (dotProgress > 0) {
      canvas.drawCircle(
        Offset(center.dx, center.dy - radius * 0.3), // Position above center
        radius * 0.12 * dotProgress, // Dot size grows with progress
        dotPaint,
      );
    }

    // Draw the vertical line of the "i"
    if (lineProgress > 0) {
      final linePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.2
        ..strokeCap = StrokeCap.round;

      final linePath = Path();
      final startY = center.dy - radius * 0.1;
      final endY = center.dy + radius * 0.3;

      // Draw line from top to bottom based on progress
      linePath.moveTo(center.dx, startY);
      linePath.lineTo(
        center.dx,
        startY + (endY - startY) * lineProgress,
      );

      canvas.drawPath(linePath, linePaint);
    }

    // Add decorative shine effect when circle is mostly complete
    if (circleProgress > 0.8) {
      final shinePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      // Position shine in upper-left quadrant
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
    // Repaint when any progress value or color changes
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.dotProgress != dotProgress ||
        oldDelegate.lineProgress != lineProgress ||
        oldDelegate.rippleProgress != rippleProgress ||
        oldDelegate.color != color;
  }
}
