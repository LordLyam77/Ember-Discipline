import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class StreakFlame extends StatefulWidget {
  final double size;
  final bool isLit;
  final bool enableFlicker;

  const StreakFlame({
    super.key,
    this.size = 80,
    this.isLit = true,
    this.enableFlicker = true,
  });

  @override
  State<StreakFlame> createState() => _StreakFlameState();
}

class _StreakFlameState extends State<StreakFlame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget.enableFlicker && widget.isLit) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(StreakFlame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enableFlicker && widget.isLit && !_controller.isAnimating) {
      _controller.repeat();
    } else if ((!widget.enableFlicker || !widget.isLit) && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size * 1.25),
          painter: _FlamePainter(
            animationValue: _controller.value,
            isLit: widget.isLit,
          ),
        );
      },
    );
  }
}

class _FlamePainter extends CustomPainter {
  final double animationValue;
  final bool isLit;

  _FlamePainter({
    required this.animationValue,
    required this.isLit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    if (!isLit) {
      // Unlit / dormant gray flame
      final grayPaint = Paint()
        ..color = EmberColors.textSecondary.withAlpha((0.3 * 255).round())
        ..style = PaintingStyle.fill;
      _drawFlameShape(canvas, w, h, 0.0, grayPaint, scale: 0.9);
      return;
    }

    // Dynamic wave oscillation
    final wave1 = math.sin(animationValue * 2 * math.pi);
    final wave2 = math.cos(animationValue * 2 * math.pi * 1.5);

    // 1. Soft Outer Flame Glow
    final glowPaint = Paint()
      ..color = EmberColors.primaryOrange.withAlpha((0.25 * 255).round())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawCircle(Offset(w / 2, h * 0.65), w * 0.45 + wave1 * 3, glowPaint);

    // 2. Outer Deep Orange Flame
    final outerFlamePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF3D00), EmberColors.primaryOrange],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;
    _drawFlameShape(canvas, w, h, wave1 * 3.5, outerFlamePaint, scale: 1.0);

    // 3. Middle Bright Orange Flame
    final midFlamePaint = Paint()
      ..shader = const LinearGradient(
        colors: [EmberColors.primaryOrange, EmberColors.brightOrange],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;
    _drawFlameShape(canvas, w, h, -wave2 * 2.5, midFlamePaint, scale: 0.72);

    // 4. Inner White-Hot Core
    final corePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD166), Colors.white],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;
    _drawFlameShape(canvas, w, h, wave1 * 1.5, corePaint, scale: 0.42);

    // 5. Floating Embers drifting upward
    final emberPaint = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < 4; i++) {
      final progress = (animationValue + i * 0.25) % 1.0;
      final emberY = h * 0.5 - (progress * h * 0.55);
      final emberX = (w / 2) + math.sin(progress * 4 * math.pi + i) * (w * 0.25);
      final emberRadius = (1.0 - progress) * 2.5 + 0.8;
      final alpha = ((1.0 - progress) * 255).clamp(0, 255).toInt();

      emberPaint.color = EmberColors.brightOrange.withAlpha(alpha);
      canvas.drawCircle(Offset(emberX, emberY), emberRadius, emberPaint);
    }
  }

  void _drawFlameShape(
    Canvas canvas,
    double w,
    double h,
    double sway,
    Paint paint, {
    required double scale,
  }) {
    canvas.save();
    // Center scaling
    canvas.translate(w / 2, h * 0.75);
    canvas.scale(scale);
    canvas.translate(-w / 2, -h * 0.75);

    final path = Path();
    final centerX = w / 2;
    final tipX = centerX + sway;
    final tipY = h * 0.12;

    path.moveTo(tipX, tipY);

    // Right curve down
    path.cubicTo(
      centerX + w * 0.35,
      h * 0.35,
      centerX + w * 0.48,
      h * 0.65,
      centerX + w * 0.25,
      h * 0.88,
    );

    // Bottom base curve
    path.cubicTo(
      centerX + w * 0.15,
      h * 0.95,
      centerX - w * 0.15,
      h * 0.95,
      centerX - w * 0.25,
      h * 0.88,
    );

    // Left curve up
    path.cubicTo(
      centerX - w * 0.48,
      h * 0.65,
      centerX - w * 0.35,
      h * 0.35,
      tipX,
      tipY,
    );

    path.close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlamePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isLit != isLit;
  }
}
