import 'dart:math';

import 'package:flutter/material.dart';

import '../custom_painters/confirmation_custom_painter.dart';

class AnimatedConfirmationWidget extends StatefulWidget {
  final Color startColor;
  final Color confirmColor;

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
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _iconMorphAnimation;
  late Animation<double> _rippleAnimation;
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
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _iconMorphAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _colorAnimation =
        ColorTween(begin: widget.startColor, end: widget.confirmColor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
    _controller.repeat(reverse: false); //Removed reverse for smooth looping
  }
}
