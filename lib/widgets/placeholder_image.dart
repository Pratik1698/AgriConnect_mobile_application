import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Shared image placeholder for machinery/professional cards.
/// Replace with real network/asset images once provider photos exist —
/// every card already isolates image rendering to this one widget,
/// so that swap will happen in one place, not per-card.
class PlaceholderImage extends StatelessWidget {
  final IconData icon;
  final double size;
  final double borderRadius;

  const PlaceholderImage({
    super.key,
    required this.icon,
    this.size = 64,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primarySoftBackground,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, color: AppColors.primary, size: size * 0.45),
    );
  }
}
