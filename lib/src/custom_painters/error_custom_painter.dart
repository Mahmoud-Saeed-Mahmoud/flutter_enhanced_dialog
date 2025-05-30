import 'dart:math';

import 'package:flutter/material.dart';

/// A custom painter that draws an animated error icon consisting of a circle and a cross.
///
/// The animation is controlled by a [progress] value between 0.0 and 1.0:
/// - From 0.0 to 0.5: Draws an animating circular arc
/// - At 0.5: Completes the circle
/// - From 0.5 to 0.75: Draws the first diagonal line of the cross
/// - From 0.75 to 1.0: Draws the second diagonal line of the cross
class ErrorCustomPainter extends CustomPainter {
  /// Controls the animation progress from 0.0 to 1.0
  final double progress;

  /// The color used to draw the error icon
  final Color color;

  /// Creates an [ErrorCustomPainter] with the specified animation [progress] and [color].
  ///
  /// The [progress] value must be between 0.0 and 1.0.
  ErrorCustomPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Configure the paint object with the desired style
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08 // Stroke width proportional to size
      ..strokeCap = StrokeCap.round;

    // Calculate the center point and radius for the circle
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4; // Circle radius proportional to size

    // Draw the circle animation (progress 0.0 to 0.5)
    if (progress < 0.5) {
      // Scale progress to range 0.0-1.0 for the circle animation
      final circleProgress = progress * 2;
      final sweepAngle = 2 * pi * circleProgress;

      // Draw an arc starting from the top (-pi/2)
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, // Start from top
        sweepAngle,
        false, // Don't include center
        paint,
      );
    } else {
      // Draw complete circle after progress reaches 0.5
      canvas.drawCircle(center, radius, paint);
    }

    // Draw the cross lines animation (progress 0.5 to 1.0)
    if (progress > 0.5) {
      // Scale progress to range 0.0-1.0 for the first line
      final lineProgress = (progress - 0.5) * 2;

      // Calculate endpoints for the first diagonal line (top-left to bottom-right)
      final startPoint1 = Offset(
        center.dx - radius * 0.6,
        center.dy - radius * 0.6,
      );
      final endPoint1 = Offset(
        center.dx + radius * 0.6,
        center.dy + radius * 0.6,
      );

      // Interpolate the end point based on progress
      final currentEnd1 = Offset.lerp(
        startPoint1,
        endPoint1,
        lineProgress,
      )!;
      canvas.drawLine(startPoint1, currentEnd1, paint);

      // Draw second diagonal line (top-right to bottom-left) after progress 0.75
      if (progress > 0.75) {
        // Scale progress to range 0.0-1.0 for the second line
        final lineProgress2 = (progress - 0.75) * 4;

        // Calculate endpoints for the second diagonal line
        final startPoint2 = Offset(
          center.dx + radius * 0.6,
          center.dy - radius * 0.6,
        );
        final endPoint2 = Offset(
          center.dx - radius * 0.6,
          center.dy + radius * 0.6,
        );

        // Interpolate the end point based on progress
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
    // Repaint when progress or color changes
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
