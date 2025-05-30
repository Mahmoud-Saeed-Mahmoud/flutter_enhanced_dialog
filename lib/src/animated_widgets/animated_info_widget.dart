import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/info_custom_painter.dart';

/// An animated widget that displays an information icon with ripple effects.
///
/// This widget creates an animated information icon that consists of:
/// - A circular background that fades in
/// - A dot that appears with an elastic effect
/// - A line that draws from top to bottom
/// - A ripple effect that continuously animates outward
///
/// The animation sequence runs continuously in forward and reverse.
class AnimatedInfoWidget extends StatefulWidget {
  /// The color to use for the info icon and animations.
  /// Defaults to [Colors.blue].
  final Color color;

  /// Creates an [AnimatedInfoWidget].
  ///
  /// [color] determines the color of the icon and its animations.
  const AnimatedInfoWidget({
    super.key,
    this.color = Colors.blue,
  });

  @override
  AnimatedInfoWidgetState createState() => AnimatedInfoWidgetState();
}

class AnimatedInfoWidgetState extends State<AnimatedInfoWidget>
    with TickerProviderStateMixin {
  /// Controls the main animation sequence (circle, dot, and line)
  late AnimationController _mainController;

  /// Controls the continuous ripple effect animation
  late AnimationController _rippleController;

  /// Animates the circular background from 0 to 1
  late Animation<double> _circleAnimation;

  /// Animates the dot appearance with elastic effect
  late Animation<double> _dotAnimation;

  /// Animates the vertical line drawing
  late Animation<double> _lineAnimation;

  /// Animates the ripple effect scaling
  late Animation<double> _rippleAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the size from constraints or use a default
        double size = min(constraints.maxWidth, constraints.maxHeight);
        if (size == double.infinity) {
          size = 100; // Default size if no constraint is passed
        }

        // Use AnimatedBuilder to rebuild only when animations change
        return AnimatedBuilder(
          animation: Listenable.merge([_mainController, _rippleController]),
          builder: (context, child) {
            return CustomPaint(
              size: Size(size, size),
              painter: InfoCustomPainter(
                circleProgress: _circleAnimation.value,
                dotProgress: _dotAnimation.value,
                lineProgress: _lineAnimation.value,
                rippleProgress: _rippleAnimation.value,
                color: widget.color,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up animation controllers to prevent memory leaks
    _mainController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize main controller for the info icon animation sequence
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Initialize ripple controller with continuous repeat
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Setup circle background animation (0.0 - 0.5 seconds)
    // Uses cubic easing for smooth fade in/out
    _circleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOutCubic),
      ),
    );

    // Setup dot animation (0.5 - 0.7 seconds)
    // Uses elastic effect for bouncy appearance
    _dotAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Setup line animation (0.7 - 1.0 seconds)
    // Uses cubic easing for smooth drawing motion
    _lineAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Setup continuous ripple animation
    // Scales from 0.5 to 1.0 with smooth easing
    _rippleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the main animation sequence with reverse playback
    _mainController.repeat(reverse: true);
  }
}
