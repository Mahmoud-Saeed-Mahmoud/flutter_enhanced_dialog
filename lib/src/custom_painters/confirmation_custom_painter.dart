import 'package:flutter/material.dart';

class ConfirmationCustomPainter extends CustomPainter {
  final double circleProgress;
  final double iconMorphProgress;
  final double rippleProgress;
  final Color color;

  ConfirmationCustomPainter({
    required this.circleProgress,
    required this.iconMorphProgress,
    required this.rippleProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final circleRadius = size.width * 0.4 * circleProgress;

    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final ripplePaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05;

    // Draw the expanding circle
    canvas.drawCircle(center, circleRadius, circlePaint);

    // Ripple Effect
    final rippleRadius = size.width * 0.5 * rippleProgress;
    canvas.drawCircle(center, rippleRadius, ripplePaint);

    // Icon morph logic
    final iconPath = Path();
    if (iconMorphProgress <= 0.5) {
      // Draw 'X' in first stage
      final double progress = iconMorphProgress * 2;
      final double startX1 = center.dx - size.width * 0.2;
      final double startY1 = center.dy - size.width * 0.2;
      final double endX1 = center.dx + size.width * 0.2;
      final double endY1 = center.dy + size.width * 0.2;

      iconPath.moveTo(startX1 + (center.dx - startX1) * progress,
          startY1 + (center.dy - startY1) * progress);
      iconPath.lineTo(endX1 + (center.dx - endX1) * progress,
          endY1 + (center.dy - endY1) * progress);

      final double startX2 = center.dx + size.width * 0.2;
      final double startY2 = center.dy - size.width * 0.2;
      final double endX2 = center.dx - size.width * 0.2;
      final double endY2 = center.dy + size.width * 0.2;

      iconPath.moveTo(startX2 + (center.dx - startX2) * progress,
          startY2 + (center.dy - startY2) * progress);
      iconPath.lineTo(endX2 + (center.dx - endX2) * progress,
          endY2 + (center.dy - endY2) * progress);
    } else {
      // Morph to checkmark after the X
      final double progress = (iconMorphProgress - 0.5) * 2;
      final double checkStartX = center.dx - size.width * 0.2;
      final double checkStartY = center.dy;
      final double checkMidX = center.dx;
      final double checkMidY = center.dy + size.width * 0.2;
      final double checkEndX = center.dx + size.width * 0.4;
      final double checkEndY = center.dy - size.width * 0.2;

      iconPath.moveTo(checkStartX + (checkMidX - checkStartX) * progress,
          checkStartY + (checkMidY - checkStartY) * progress);
      iconPath.lineTo(checkMidX, checkMidY);
      iconPath.lineTo(checkMidX + (checkEndX - checkMidX) * progress,
          checkMidY + (checkEndY - checkMidY) * progress);
    }

    final iconPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.06
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(iconPath, iconPaint);
  }

  @override
  bool shouldRepaint(covariant ConfirmationCustomPainter oldDelegate) {
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.iconMorphProgress != iconMorphProgress ||
        oldDelegate.rippleProgress != rippleProgress ||
        oldDelegate.color != color;
  }
}
