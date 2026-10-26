import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_theme.dart';

enum GlowButtonVariant { primary, secondary, danger, ghost }

class GlowButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final GlowButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;

  const GlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.variant = GlowButtonVariant.primary,
    this.isLoading = false,
    this.width,
    this.height = 54,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    Color startColor;
    Color endColor;
    Color textColor = EmberColors.textPrimary;
    Color? borderColor;
    List<BoxShadow>? shadows;

    switch (widget.variant) {
      case GlowButtonVariant.primary:
        startColor = EmberColors.primaryOrange;
        endColor = EmberColors.brightOrange;
        textColor = Colors.white;
        if (isEnabled) {
          shadows = [
            BoxShadow(
              color: EmberColors.primaryOrange.withAlpha((0.35 * 255).round()),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ];
        }
        break;
      case GlowButtonVariant.secondary:
        startColor = EmberColors.cardElevated;
        endColor = EmberColors.card;
        borderColor = EmberColors.border;
        textColor = EmberColors.textPrimary;
        break;
      case GlowButtonVariant.danger:
        startColor = EmberColors.slipWarning;
        endColor = const Color(0xFFC93B40);
        textColor = Colors.white;
        if (isEnabled) {
          shadows = [
            BoxShadow(
              color: EmberColors.slipWarning.withAlpha((0.3 * 255).round()),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ];
        }
        break;
      case GlowButtonVariant.ghost:
        startColor = Colors.transparent;
        endColor = Colors.transparent;
        textColor = EmberColors.textSecondary;
        break;
    }

    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(EmberTheme.buttonRadius),
          gradient: LinearGradient(
            colors: isEnabled
                ? [startColor, endColor]
                : [startColor.withAlpha((0.5 * 255).round()), endColor.withAlpha((0.5 * 255).round())],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
          boxShadow: shadows,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(EmberTheme.buttonRadius),
            onTapDown: (_) => isEnabled ? setState(() => _isPressed = true) : null,
            onTapUp: (_) => isEnabled ? setState(() => _isPressed = false) : null,
            onTapCancel: () => isEnabled ? setState(() => _isPressed = false) : null,
            onTap: isEnabled
                ? () {
                    HapticFeedback.lightImpact();
                    widget.onPressed!();
                  }
                : null,
            child: Padding(
              padding: widget.padding,
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            widget.icon!,
                            const SizedBox(width: 8),
                          ],
                          Text(
                            widget.text,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
