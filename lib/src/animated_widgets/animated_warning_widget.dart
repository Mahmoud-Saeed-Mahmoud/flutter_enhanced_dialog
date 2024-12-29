import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/src/custom_painters/warning_custom_painter.dart';

class AnimatedWarningWidget extends StatefulWidget {
  final Color color;
  final bool isAnimating;

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
  late AnimationController _circleController;
  late AnimationController _pulseController;
  late AnimationController _exclamationController;

  late Animation<double> _circleAnimation;
  late Animation<double> _pulseAnimation;
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
        return AnimatedBuilder(
          animation: Listenable.merge(
            [
              _circleController,
              _pulseController,
              _exclamationController,
            ],
          ),
          builder: (context, child) {
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
    _circleController.dispose();
    _pulseController.dispose();
    _exclamationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Circle animation controller
    _circleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Exclamation mark animation controller
    _exclamationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Circle drawing animation
    _circleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _circleController,
        curve: Curves.easeOut,
      ),
    );

    // Pulsing effect animation
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

    // Exclamation mark animation
    _exclamationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _exclamationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start animations
    _circleController.forward();
    _exclamationController.forward();

    if (widget.isAnimating) {
      _pulseController.repeat();
    }
  }
}
