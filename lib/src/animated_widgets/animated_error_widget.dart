import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/error_custom_painter.dart';

/// An animated widget that displays an error symbol with a pulsing animation effect.
///
/// This widget creates a custom-painted error symbol that animates continuously
/// with a pulsing effect. The error symbol's color can be customized through
/// the [color] parameter.
///
/// Example usage:
/// ```dart
/// AnimatedErrorWidget(
///   color: Colors.red,
/// )
/// ```
class AnimatedErrorWidget extends StatefulWidget {
  /// The color of the error symbol.
  ///
  /// Defaults to [Colors.red] if not specified.
  final Color color;

  /// Creates an [AnimatedErrorWidget] with the specified [color].
  ///
  /// The [key] parameter is optional and follows the standard Flutter widget key pattern.
  const AnimatedErrorWidget({
    super.key,
    this.color = Colors.red,
  });

  @override
  AnimatedErrorWidgetState createState() => AnimatedErrorWidgetState();
}

/// The state class for [AnimatedErrorWidget].
///
/// Manages the animation controller and animation for the pulsing effect.
class AnimatedErrorWidgetState extends State<AnimatedErrorWidget>
    with SingleTickerProviderStateMixin {
  /// Controller for managing the pulsing animation
  late AnimationController _controller;

  /// Animation that drives the pulsing effect
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the appropriate size based on layout constraints
        double size = min(constraints.maxWidth, constraints.maxHeight);
        if (size == double.infinity) {
          size = 100; // Default size if no constraint is passed
        }

        // Build the animated error symbol using CustomPaint
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: Size(size, size),
              painter: ErrorCustomPainter(
                progress: _animation.value,
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
    // Clean up animation controller when widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 2 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Repeat animation with reverse effect

    // Create a curved animation for smooth pulsing effect
    _animation = CurvedAnimation(
      parent: _controller,
      curve:
          Curves.easeInOutCubic, // Use cubic ease for natural-looking animation
    );
  }
}
