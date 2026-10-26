import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_theme.dart';

class EmberCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final bool hasGlow;
  final bool isElevated;
  final BorderRadius? borderRadius;
  final Border? customBorder;

  const EmberCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.backgroundColor = EmberColors.card,
    this.hasGlow = false,
    this.isElevated = false,
    this.borderRadius,
    this.customBorder,
  });

  @override
  State<EmberCard> createState() => _EmberCardState();
}

class _EmberCardState extends State<EmberCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = widget.borderRadius ??
        BorderRadius.circular(EmberTheme.cardRadius);

    Widget content = AnimatedScale(
      scale: _isPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.isElevated ? EmberColors.cardElevated : widget.backgroundColor,
          borderRadius: effectiveRadius,
          border: widget.customBorder ??
              Border.all(
                color: widget.hasGlow
                    ? EmberColors.primaryOrange.withAlpha((0.6 * 255).round())
                    : EmberColors.border,
                width: widget.hasGlow ? 1.5 : 1.0,
              ),
          boxShadow: widget.hasGlow
              ? [
                  BoxShadow(
                    color: EmberColors.primaryOrange.withAlpha((0.15 * 255).round()),
                    blurRadius: 24,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: widget.child,
      ),
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          HapticFeedback.lightImpact();
          widget.onTap!();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    return content;
  }
}
