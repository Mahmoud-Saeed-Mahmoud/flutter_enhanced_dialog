import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/success_custom_painter.dart';

/// An animated widget that displays a success checkmark animation.
///
/// This widget creates an animated success indicator that consists of two parts:
/// 1. A circular outline that draws from 0 to 360 degrees
/// 2. A checkmark that appears and animates with an elastic effect
///
/// The animation automatically repeats in reverse, creating a continuous effect.
///
/// Example usage:
/// ```dart
/// AnimatedSuccessWidget(
///   color: Colors.green, // Optional - defaults to Colors.green
/// )
/// ```
class AnimatedSuccessWidget extends StatefulWidget {
  /// The color used for drawing both the circle and checkmark.
  /// Defaults to Colors.green if not specified.
  final Color color;

  /// Creates an instance of [AnimatedSuccessWidget].
  ///
  /// Parameters:
  /// - [key]: Widget key for identification
  /// - [color]: The color used for the animation (defaults to Colors.green)
  const AnimatedSuccessWidget({
    super.key,
    this.color = Colors.green,
  });

  @override
  AnimatedSuccessWidgetState createState() => AnimatedSuccessWidgetState();
}

class AnimatedSuccessWidgetState extends State<AnimatedSuccessWidget>
    with SingleTickerProviderStateMixin {
  /// Controls the overall animation sequence
  late AnimationController _controller;

  /// Animation for the circular outline (0.0 to 0.7 of total duration)
  late Animation<double> _circleAnimation;

  /// Animation for the checkmark (0.3 to 1.0 of total duration with elastic effect)
  late Animation<double> _checkAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the widget size based on layout constraints
        double size = min(constraints.maxWidth, constraints.maxHeight);
        if (size == double.infinity) {
          size = 100; //Default size if not constraint is passed
        }

        // Use AnimatedBuilder for efficient rebuilds
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(size, size),
              painter: SuccessCustomPainter(
                color: widget.color,
                circleProgress: _circleAnimation.value,
                checkProgress: _checkAnimation.value,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up animation controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with 2-second duration
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Configure circle animation to run from 0% to 70% of the total duration
    _circleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    // Configure checkmark animation to run from 30% to 100% of the total duration
    // Uses elastic curve for bouncy effect
    _checkAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Start the animation and make it repeat in reverse
    _controller.repeat(reverse: true);
  }
}
