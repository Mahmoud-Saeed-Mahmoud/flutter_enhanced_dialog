import 'dart:math';

import 'package:flutter/material.dart';

import '../custom_painters/confirmation_custom_painter.dart';

/// An animated widget that displays a confirmation animation with morphing circle and icon.
///
/// This widget creates a smooth animation sequence that includes:
/// - A circular progress animation
/// - An icon that morphs into shape
/// - A ripple effect
/// - A color transition from [startColor] to [confirmColor]
///
/// The animation runs continuously in a loop for visual feedback.
class AnimatedConfirmationWidget extends StatefulWidget {
  /// The initial color of the animation
  final Color startColor;

  /// The final color that the animation transitions to
  final Color confirmColor;

  /// Creates an [AnimatedConfirmationWidget].
  ///
  /// [startColor] defaults to Colors.blue
  /// [confirmColor] defaults to Colors.green
  const AnimatedConfirmationWidget({
    super.key,
    this.startColor = Colors.blue,
    this.confirmColor = Colors.green,
  });

  @override
  AnimatedConfirmationWidgetState createState() =>
      AnimatedConfirmationWidgetState();
}

class AnimatedConfirmationWidgetState extends State<AnimatedConfirmationWidget>
    with TickerProviderStateMixin {
  /// Controls the overall animation sequence
  late AnimationController _controller;

  /// Animation for the circular progress
  late Animation<double> _circleAnimation;

  /// Animation for morphing the icon shape
  late Animation<double> _iconMorphAnimation;

  /// Animation for the ripple effect
  late Animation<double> _rippleAnimation;

  /// Animation for color transition
  late Animation<Color?> _colorAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the size from constraints or use a default
        double size = min(constraints.maxWidth, constraints.maxHeight);
        if (size == double.infinity) {
          size = 100; //Default size if not constraint is passed
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(size, size),
              painter: ConfirmationCustomPainter(
                circleProgress: _circleAnimation.value,
                iconMorphProgress: _iconMorphAnimation.value,
                rippleProgress: _rippleAnimation.value,
                color: _colorAnimation.value ?? widget.startColor,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the animation controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize the main animation controller with a 1.5 second duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Setup the circular progress animation with an ease-in-out curve
    _circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Setup the icon morphing animation to start after a slight delay (20% into the animation)
    _iconMorphAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Setup the ripple animation to complete earlier (at 80% of the total duration)
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    // Setup the color transition animation
    _colorAnimation =
        ColorTween(begin: widget.startColor, end: widget.confirmColor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );

    // Start the animation loop without reversing for smooth continuous animation
    _controller.repeat(reverse: false); //Removed reverse for smooth looping
  }
}
