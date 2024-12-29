import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/info_custom_painter.dart';

class AnimatedInfoWidget extends StatefulWidget {
  final Color color;

  const AnimatedInfoWidget({
    super.key,
    this.color = Colors.blue,
  });

  @override
  AnimatedInfoWidgetState createState() => AnimatedInfoWidgetState();
}

class AnimatedInfoWidgetState extends State<AnimatedInfoWidget>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _rippleController;
  late Animation<double> _circleAnimation;
  late Animation<double> _dotAnimation;
  late Animation<double> _lineAnimation;
  late Animation<double> _rippleAnimation;

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
    _mainController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Main controller for the info icon animation
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Ripple effect controller
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Circle background animation
    _circleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOutCubic),
      ),
    );

    // Dot animation
    _dotAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Line animation
    _lineAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Ripple animation
    _rippleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _mainController.repeat(reverse: true);
  }
}
