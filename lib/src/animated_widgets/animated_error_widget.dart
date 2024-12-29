import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/error_custom_painter.dart';

class AnimatedErrorWidget extends StatefulWidget {
  final Color color;

  const AnimatedErrorWidget({
    super.key,
    this.color = Colors.red,
  });

  @override
  AnimatedErrorWidgetState createState() => AnimatedErrorWidgetState();
}

class AnimatedErrorWidgetState extends State<AnimatedErrorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  get math => null;

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
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 1.5 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Create a curved animation for smooth effect
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }
}
