import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;

  const StatChip({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: EmberColors.cardElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: EmberColors.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: iconColor ?? EmberColors.primaryOrange,
            ),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: EmberColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? EmberColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
