import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/warning_custom_painter.dart';

/// A widget that displays an animated warning icon with a pulsing effect.
///
/// This widget creates a warning icon consisting of a circle and an exclamation mark,
/// with customizable color and animation states. The warning icon features three
/// distinct animations:
/// 1. Circle drawing animation
/// 2. Pulsing effect (can be disabled)
/// 3. Exclamation mark appearance animation
class AnimatedWarningWidget extends StatefulWidget {
  /// The color of the warning icon. Defaults to [Colors.yellow].
  final Color color;

  /// Controls whether the pulsing animation is active.
  /// When true, the icon will continuously pulse. Defaults to true.
  final bool isAnimating;

  /// Creates an [AnimatedWarningWidget].
  ///
  /// [color] - The color of the warning icon
  /// [isAnimating] - Whether the pulsing animation should be active
  const AnimatedWarningWidget({
    super.key,
    this.color = Colors.yellow,
    this.isAnimating = true,
  });

  @override
  AnimatedWarningWidgetState createState() => AnimatedWarningWidgetState();
}

class AnimatedWarningWidgetState extends State<AnimatedWarningWidget>
    with TickerProviderStateMixin {
  /// Controller for the circle drawing animation
  late AnimationController _circleController;

  /// Controller for the pulsing effect animation
  late AnimationController _pulseController;

  /// Controller for the exclamation mark appearance animation
  late AnimationController _exclamationController;

  /// Animation for drawing the circle (0.0 to 1.0)
  late Animation<double> _circleAnimation;

  /// Animation for the pulsing effect (1.0 to 1.2 and back)
  late Animation<double> _pulseAnimation;

  /// Animation for drawing the exclamation mark (0.0 to 1.0)
  late Animation<double> _exclamationAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the size from constraints or use a default
        double size = min(constraints.maxWidth, constraints.maxHeight);
        if (size == double.infinity) {
          size = 100; //Default size if not constraint is passed
        }

        // Combine all animations into a single listenable for efficiency
        return AnimatedBuilder(
          animation: Listenable.merge(
            [
              _circleController,
              _pulseController,
              _exclamationController,
            ],
          ),
          builder: (context, child) {
            // Apply the pulsing scale transformation
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: CustomPaint(
                size: Size(size, size),
                painter: WarningCustomPainter(
                  color: widget.color,
                  circleProgress: _circleAnimation.value,
                  exclamationProgress: _exclamationAnimation.value,
                ),
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
    _circleController.dispose();
    _pulseController.dispose();
    _exclamationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize circle animation controller (800ms duration)
    _circleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize pulse animation controller (1500ms duration)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Initialize exclamation mark animation controller (400ms duration)
    _exclamationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Set up circle drawing animation with easeOut curve
    _circleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _circleController,
        curve: Curves.easeOut,
      ),
    );

    // Set up pulsing effect animation sequence (scale 1.0 -> 1.2 -> 1.0)
    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Set up exclamation mark animation with elastic effect
    _exclamationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _exclamationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start the initial animations
    _circleController.forward(); // Draw the circle
    _exclamationController.forward(); // Show the exclamation mark

    // Start pulsing animation if enabled
    if (widget.isAnimating) {
      _pulseController.repeat();
    }
  }
}
