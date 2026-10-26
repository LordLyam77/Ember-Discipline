import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class EmberParticle {
  final double angle;
  final double speed;
  final double radius;
  final Color color;

  EmberParticle({
    required this.angle,
    required this.speed,
    required this.radius,
    required this.color,
  });
}

class EmberBurst extends StatefulWidget {
  final VoidCallback? onFinished;

  const EmberBurst({super.key, this.onFinished});

  @override
  State<EmberBurst> createState() => _EmberBurstState();
}

class _EmberBurstState extends State<EmberBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<EmberParticle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    // Generate 35 glowing ember particles
    final colors = [
      EmberColors.primaryOrange,
      EmberColors.brightOrange,
      const Color(0xFFFFD166),
      Colors.white,
    ];

    for (int i = 0; i < 35; i++) {
      _particles.add(
        EmberParticle(
          angle: _random.nextDouble() * 2 * math.pi,
          speed: 80 + _random.nextDouble() * 140,
          radius: 2 + _random.nextDouble() * 3.5,
          color: colors[_random.nextInt(colors.length)],
        ),
      );
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward().then((_) => widget.onFinished?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: _EmberBurstPainter(
              progress: _controller.value,
              particles: _particles,
            ),
          );
        },
      ),
    );
  }
}

class _EmberBurstPainter extends CustomPainter {
  final double progress;
  final List<EmberParticle> particles;

  _EmberBurstPainter({
    required this.progress,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      final distance = p.speed * Curves.easeOutQuad.transform(progress);
      // Drift upwards slightly with gravity resistance
      final yOffset = distance * math.sin(p.angle) - (progress * 40);
      final xOffset = distance * math.cos(p.angle);

      final currentPos = Offset(center.dx + xOffset, center.dy + yOffset);
      final alpha = ((1.0 - progress) * 255).clamp(0, 255).toInt();
      final currentRadius = p.radius * (1.0 - (progress * 0.4));

      paint.color = p.color.withAlpha(alpha);
      canvas.drawCircle(currentPos, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(_EmberBurstPainter oldDelegate) => true;
}
