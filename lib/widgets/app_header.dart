import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'location_chip.dart';

/// Top greeting header for the Farmer Dashboard:
/// "Good Morning, Farmer 👋" + current location + profile avatar.
class AppHeader extends StatelessWidget {
  final String greeting;
  final String locationLabel;
  final VoidCallback? onProfileTap;

  const AppHeader({
    super.key,
    required this.greeting,
    required this.locationLabel,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              LocationChip(label: locationLabel),
            ],
          ),
        ),
        GestureDetector(
          onTap: onProfileTap,
          child: const CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primarySoftBackground,
            child: Icon(Icons.person, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
