import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Small inline label with a pin icon — used for distance ("8.2 km")
/// and general location text throughout cards and headers.
class LocationChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const LocationChip({
    super.key,
    required this.label,
    this.icon = Icons.location_on_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
