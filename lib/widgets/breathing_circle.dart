import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class BreathingCircle extends StatefulWidget {
  final double size;
  final ValueChanged<String>? onPhaseChanged;

  const BreathingCircle({
    super.key,
    this.size = 240,
    this.onPhaseChanged,
  });

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _currentPhase = 'Inhale';

  // 4s Inhale, 4s Hold, 6s Exhale = 14s total cycle
  static const int inhaleMs = 4000;
  static const int holdMs = 4000;
  static const int exhaleMs = 6000;
  static const int totalCycleMs = inhaleMs + holdMs + exhaleMs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: totalCycleMs),
    )..addListener(_updatePhase)
      ..repeat();
  }

  void _updatePhase() {
    final currentMs = (_controller.value * totalCycleMs).round();
    String newPhase;

    if (currentMs < inhaleMs) {
      newPhase = 'Inhale';
    } else if (currentMs < inhaleMs + holdMs) {
      newPhase = 'Hold';
    } else {
      newPhase = 'Exhale';
    }

    if (newPhase != _currentPhase) {
      setState(() => _currentPhase = newPhase);
      widget.onPhaseChanged?.call(newPhase);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculateScale() {
    final currentMs = (_controller.value * totalCycleMs).round();
    if (currentMs < inhaleMs) {
      // Scale from 0.7 to 1.0
      final t = currentMs / inhaleMs;
      return 0.7 + (0.3 * Curves.easeInOutSine.transform(t));
    } else if (currentMs < inhaleMs + holdMs) {
      // Hold at 1.0 with subtle pulse
      final t = (currentMs - inhaleMs) / holdMs;
      return 1.0 + (0.03 * math.sin(t * math.pi));
    } else {
      // Scale down from 1.0 to 0.7
      final t = (currentMs - inhaleMs - holdMs) / exhaleMs;
      return 1.0 - (0.3 * Curves.easeInOutSine.transform(t));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = _calculateScale();

        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Soft Glow Ring
              Transform.scale(
                scale: scale * 1.15,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: EmberColors.primaryOrange.withAlpha((0.15 * 255).round()),
                    boxShadow: [
                      BoxShadow(
                        color: EmberColors.primaryOrange.withAlpha((0.2 * 255).round()),
                        blurRadius: 32,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),

              // Main Breathing Sphere
              Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.size * 0.85,
                  height: widget.size * 0.85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        EmberColors.brightOrange,
                        EmberColors.primaryOrange,
                        Color(0xFFCC4400),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: EmberColors.primaryOrange.withAlpha((0.4 * 255).round()),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),

              // Phase Text Prompt
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currentPhase.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _currentPhase == 'Inhale'
                        ? 'Fill your lungs (4s)'
                        : _currentPhase == 'Hold'
                            ? 'Keep steady (4s)'
                            : 'Release slowly (6s)',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
