import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Small "Available" / "Unavailable" indicator — a colored dot + label.
///
/// Extracted in Stage 6 from MachineryCard and ProfessionalCard, which
/// previously duplicated this exact icon/color/text logic identically.
/// Any future card type (e.g. a Worker card, if that's ever revisited)
/// should reuse this instead of re-inlining it again.
class AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;

  const AvailabilityBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final Color color = isAvailable ? AppColors.success : AppColors.error;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 8, color: color),
        const SizedBox(width: 4),
        Text(
          isAvailable ? 'Available' : 'Unavailable',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
