import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final double borderRadius;
  final EdgeInsets? padding;

  const GradientCard({
    super.key,
    required this.child,
    this.colors,
    this.borderRadius = 24,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors ??
              [
                AppColors.primary,
                const Color(0xFF1D4ED8),
              ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: (colors?.first ?? AppColors.primary)
                .withValues(alpha: 0.3),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}