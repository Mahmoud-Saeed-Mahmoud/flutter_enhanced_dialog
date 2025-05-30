import 'package:flutter/material.dart';

/// A custom painter that draws an animated confirmation indicator
/// with a morphing icon (X to checkmark), expanding circle and ripple effect.
///
/// The animation is controlled by three progress values:
/// - [circleProgress]: Controls the expansion of the main circle (0.0 to 1.0)
/// - [iconMorphProgress]: Controls the icon morphing animation (0.0 to 1.0)
///   - 0.0 to 0.5: Draws an X that collapses to center
///   - 0.5 to 1.0: Morphs from center into a checkmark
/// - [rippleProgress]: Controls the outer ripple effect animation (0.0 to 1.0)
class ConfirmationCustomPainter extends CustomPainter {
  /// Progress value for the expanding circle animation (0.0 to 1.0)
  final double circleProgress;

  /// Progress value for the icon morphing animation (0.0 to 1.0)
  final double iconMorphProgress;

  /// Progress value for the ripple effect animation (0.0 to 1.0)
  final double rippleProgress;

  /// The color used for the circle and ripple effect
  final Color color;

  /// Creates a [ConfirmationCustomPainter] with the required animation progress values
  ConfirmationCustomPainter({
    required this.circleProgress,
    required this.iconMorphProgress,
    required this.rippleProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    // Calculate main circle radius - 40% of widget width
    final circleRadius = size.width * 0.4 * circleProgress;

    // Configure paint for main circle
    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Configure paint for ripple effect - 30% opacity
    final ripplePaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05;

    // Draw the expanding circle
    canvas.drawCircle(center, circleRadius, circlePaint);

    // Draw ripple effect - 50% of widget width
    final rippleRadius = size.width * 0.5 * rippleProgress;
    canvas.drawCircle(center, rippleRadius, ripplePaint);

    // Create path for icon animation
    final iconPath = Path();
    if (iconMorphProgress <= 0.5) {
      // First half of animation: Draw collapsing 'X'
      final double progress = iconMorphProgress * 2;

      // Calculate coordinates for first line of X
      final double startX1 = center.dx - size.width * 0.2;
      final double startY1 = center.dy - size.width * 0.2;
      final double endX1 = center.dx + size.width * 0.2;
      final double endY1 = center.dy + size.width * 0.2;

      // Draw first line, interpolating towards center
      iconPath.moveTo(startX1 + (center.dx - startX1) * progress,
          startY1 + (center.dy - startY1) * progress);
      iconPath.lineTo(endX1 + (center.dx - endX1) * progress,
          endY1 + (center.dy - endY1) * progress);

      // Calculate coordinates for second line of X
      final double startX2 = center.dx + size.width * 0.2;
      final double startY2 = center.dy - size.width * 0.2;
      final double endX2 = center.dx - size.width * 0.2;
      final double endY2 = center.dy + size.width * 0.2;

      // Draw second line, interpolating towards center
      iconPath.moveTo(startX2 + (center.dx - startX2) * progress,
          startY2 + (center.dy - startY2) * progress);
      iconPath.lineTo(endX2 + (center.dx - endX2) * progress,
          endY2 + (center.dy - endY2) * progress);
    } else {
      // Second half of animation: Morph to checkmark
      final double progress = (iconMorphProgress - 0.5) * 2;

      // Calculate checkmark coordinates
      final double checkStartX = center.dx - size.width * 0.2;
      final double checkStartY = center.dy;
      final double checkMidX = center.dx;
      final double checkMidY = center.dy + size.width * 0.2;
      final double checkEndX = center.dx + size.width * 0.4;
      final double checkEndY = center.dy - size.width * 0.2;

      // Draw checkmark, interpolating from center
      iconPath.moveTo(checkStartX + (checkMidX - checkStartX) * progress,
          checkStartY + (checkMidY - checkStartY) * progress);
      iconPath.lineTo(checkMidX, checkMidY);
      iconPath.lineTo(checkMidX + (checkEndX - checkMidX) * progress,
          checkMidY + (checkEndY - checkMidY) * progress);
    }

    // Configure paint for icon
    final iconPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.06
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the icon path
    canvas.drawPath(iconPath, iconPaint);
  }

  @override
  bool shouldRepaint(covariant ConfirmationCustomPainter oldDelegate) {
    // Repaint when any of the progress values or color changes
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.iconMorphProgress != iconMorphProgress ||
        oldDelegate.rippleProgress != rippleProgress ||
        oldDelegate.color != color;
  }
}
