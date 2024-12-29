import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
// Example usage with modern content

class FlutterEnhancedDialog extends StatefulWidget {
  final Widget child;
  final Color accentColor;
  final Widget icon;
  final String title;
  final String message;
  final String? yesButtonText;
  final String? noButtonText;
  final VoidCallback? okPressed;
  final VoidCallback? yesPressed;
  final VoidCallback? noPressed;
  final String? okButtonText;
  factory FlutterEnhancedDialog.confirm({
    Key? key,
    required String title,
    required String message,
    String? yesButtonText,
    String? noButtonText,
    Widget? icon,
    Widget? child,
    VoidCallback? yesPressed,
    VoidCallback? noPressed,
  }) =>
      FlutterEnhancedDialog._(
        key: key,
        accentColor: Colors.orange,
        icon: icon ?? const Icon(Icons.help_outline),
        title: title,
        message: message,
        yesButtonText: yesButtonText,
        noButtonText: noButtonText,
        yesPressed: yesPressed,
        noPressed: noPressed,
        child: child ??
            _buildDefaultDialogContent(
              title,
              message,
              icon ?? const Icon(Icons.help_outline),
              Colors.orange,
              isConfirm: true,
              yesPressed: yesPressed,
              noPressed: noPressed,
            ),
      );

  factory FlutterEnhancedDialog.error({
    Key? key,
    required String title,
    required String message,
    String? okButtonText,
    Widget? icon,
    Widget? child,
    VoidCallback? okPressed,
  }) =>
      FlutterEnhancedDialog._(
        key: key,
        accentColor: Colors.red,
        icon: icon ?? const Icon(Icons.error),
        title: title,
        message: message,
        okButtonText: okButtonText,
        okPressed: okPressed,
        child: child ??
            _buildDefaultDialogContent(
              title,
              message,
              icon ?? const Icon(Icons.error),
              Colors.red,
              isConfirm: false,
              okPressed: okPressed,
            ),
      );

  factory FlutterEnhancedDialog.info({
    Key? key,
    required String title,
    required String message,
    String? okButtonText,
    Widget? icon,
    Widget? child,
    VoidCallback? okPressed,
  }) =>
      FlutterEnhancedDialog._(
        key: key,
        accentColor: Colors.blue,
        icon: icon ?? const Icon(Icons.info_outline),
        title: title,
        message: message,
        okButtonText: okButtonText,
        okPressed: okPressed,
        child: child ??
            _buildDefaultDialogContent(
              title,
              message,
              icon ?? const Icon(Icons.info_outline),
              Colors.blue,
              isConfirm: false,
              okPressed: okPressed,
            ),
      );

  factory FlutterEnhancedDialog.primary({
    required String title,
    required String message,
    String? buttonText,
    Widget? icon,
    Widget? child,
    VoidCallback? onGotItPressed,
  }) {
    return FlutterEnhancedDialog._(
      accentColor: const Color(0xFF6C63FF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: icon ??
                const Icon(
                  Icons.celebration,
                  size: 40,
                  color: Color(0xFF6C63FF),
                ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF636E72),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  onGotItPressed?.call();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  buttonText ?? 'Got it!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  factory FlutterEnhancedDialog.success({
    Key? key,
    required String title,
    required String message,
    String? okButtonText,
    Widget? icon,
    Widget? child,
    VoidCallback? okPressed,
  }) =>
      FlutterEnhancedDialog._(
        key: key,
        accentColor: Colors.green,
        icon: icon ?? const Icon(Icons.check_circle),
        title: title,
        message: message,
        okPressed: okPressed,
        child: child ??
            _buildDefaultDialogContent(
              title,
              message,
              okButtonText: okButtonText,
              icon ?? const Icon(Icons.check_circle),
              Colors.green,
              isConfirm: false,
              okPressed: okPressed,
            ),
      );
  factory FlutterEnhancedDialog.warning({
    Key? key,
    required String title,
    required String message,
    String? okButtonText,
    Widget? icon,
    Widget? customWidget,
    VoidCallback? okPressed,
  }) =>
      FlutterEnhancedDialog._(
        key: key,
        accentColor: Colors.amber,
        icon: icon ?? const Icon(Icons.warning),
        title: title,
        message: message,
        okButtonText: okButtonText,
        okPressed: okPressed,
        child: customWidget ??
            _buildDefaultDialogContent(
              title,
              message,
              okButtonText: okButtonText,
              icon ?? const Icon(Icons.warning),
              Colors.amber,
              isConfirm: false,
              okPressed: okPressed,
            ),
      );

  const FlutterEnhancedDialog._({
    super.key,
    required this.child,
    this.accentColor = const Color(0xFF6C63FF),
    this.icon = const Icon(Icons.info_outline),
    this.title = 'Dialog Title',
    this.message = 'Dialog Message',
    this.okPressed,
    this.yesPressed,
    this.noPressed,
    this.okButtonText = 'OK',
    this.yesButtonText = 'Yes',
    this.noButtonText = 'No',
  });

  @override
  State<FlutterEnhancedDialog> createState() => _FlutterEnhancedDialogState();

  static Widget _buildDefaultDialogContent(
    String title,
    String message,
    Widget icon,
    Color color, {
    required bool isConfirm,
    VoidCallback? okPressed,
    VoidCallback? yesPressed,
    VoidCallback? noPressed,
    String? okButtonText,
    String? yesButtonText,
    String? noButtonText,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 100,
                maxWidth: 70,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.dstIn,
                ),
                child: icon,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3436),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF636E72),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            if (isConfirm)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      yesPressed?.call();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      yesButtonText ?? 'Yes',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      noPressed?.call();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      noButtonText ?? 'No',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () {
                  okPressed?.call();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  okButtonText ?? 'Ok',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        );
      },
    );
  }
}

class Particle {
  Offset position;
  Color color;
  double speed;
  double size;
  double angle;

  Particle({
    required this.position,
    required this.color,
    required this.speed,
    required this.size,
    required this.angle,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _FlutterEnhancedDialogState extends State<FlutterEnhancedDialog>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _particleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  late Animation<double> _opacityAnimation;
  late List<Particle> particles;

  final int particleCount = 20;
  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, __) async {
        await _mainController.reverse();
      },
      child: GestureDetector(
        onVerticalDragStart: (details) {
          _isDragging = true;
          _dragOffset = 0.0;
        },
        onVerticalDragUpdate: (details) {
          if (_isDragging) {
            setState(
              () {
                _dragOffset += details.delta.dy;
              },
            );
          }
        },
        onVerticalDragEnd: (details) {
          if (_dragOffset.abs() > 100) {
            Navigator.of(context).pop();
          } else {
            setState(() {
              _dragOffset = 0.0;
              _isDragging = false;
            });
          }
        },
        child: AnimatedBuilder(
          animation: _mainController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Center(
                child: Transform.translate(
                  offset: Offset(0, _dragOffset),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 300,
                      constraints: const BoxConstraints(maxHeight: 400),
                      child: Stack(
                        children: [
                          // Particle Layer
                          RepaintBoundary(
                            child: AnimatedBuilder(
                              animation: _particleController,
                              builder: (context, child) {
                                _updateParticles(_particleController.value);
                                return CustomPaint(
                                  size: const Size(300, 400),
                                  painter: ParticlePainter(particles),
                                );
                              },
                            ),
                          ),
                          // Glass Effect Container
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: _blurAnimation.value,
                                sigmaY: _blurAnimation.value,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.accentColor.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Drag Handle
                                    Center(
                                      child: Container(
                                        width: 40,
                                        height: 4,
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withValues(
                                            alpha: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                    // Content
                                    widget.child,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeParticles();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.elasticOut,
      ),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeIn,
      ),
    );

    _mainController.forward();
  }

  void _initializeParticles() {
    final random = Random();
    particles = List.generate(
      particleCount,
      (index) {
        return Particle(
          position: Offset(
            random.nextDouble() * 300,
            random.nextDouble() * 400,
          ),
          color: widget.accentColor.withValues(alpha: 0.3),
          speed: random.nextDouble() * 2 + 0.5,
          size: random.nextDouble() * 15 + 5,
          angle: random.nextDouble() * pi * 2,
        );
      },
    );
  }

  void _updateParticles(double delta) {
    for (var particle in particles) {
      particle.position += Offset(
        cos(particle.angle) * particle.speed,
        sin(particle.angle) * particle.speed,
      );

      // Bounce off boundaries
      if (particle.position.dx < 0 || particle.position.dx > 300) {
        particle.angle = pi - particle.angle;
      }
      if (particle.position.dy < 0 || particle.position.dy > 400) {
        particle.angle = -particle.angle;
      }
    }
  }
}

extension ShowDialog on FlutterEnhancedDialog {
  void show(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.1),
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: this,
        );
      },
    );
  }
}
