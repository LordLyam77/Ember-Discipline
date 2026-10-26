import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ProgressBarShine extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final BorderRadius? borderRadius;
  final Color backgroundColor;
  final List<Color>? gradientColors;
  final bool animateShine;

  const ProgressBarShine({
    super.key,
    required this.progress,
    this.height = 10,
    this.borderRadius,
    this.backgroundColor = EmberColors.cardElevated,
    this.gradientColors,
    this.animateShine = true,
  });

  @override
  State<ProgressBarShine> createState() => _ProgressBarShineState();
}

class _ProgressBarShineState extends State<ProgressBarShine>
    with SingleTickerProviderStateMixin {
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clampedProgress = widget.progress.clamp(0.0, 1.0);
    final radius = widget.borderRadius ?? BorderRadius.circular(widget.height / 2);
    final fillColors = widget.gradientColors ??
        const [EmberColors.primaryOrange, EmberColors.brightOrange];

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: radius,
          border: Border.all(color: EmberColors.border, width: 0.5),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fillWidth = constraints.maxWidth * clampedProgress;

            return Stack(
              children: [
                // Animated fill bar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  width: fillWidth,
                  height: widget.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: fillColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                        color: fillColors.first.withAlpha((0.3 * 255).round()),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),

                // Moving shine overlay
                if (widget.animateShine && clampedProgress > 0.05)
                  AnimatedBuilder(
                    animation: _shineController,
                    builder: (context, child) {
                      final shinePosition =
                          (_shineController.value * (fillWidth + 60)) - 30;

                      return Positioned(
                        left: shinePosition,
                        top: 0,
                        bottom: 0,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: radius,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withAlpha(0),
                                  Colors.white.withAlpha((0.45 * 255).round()),
                                  Colors.white.withAlpha(0),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
