import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'placeholder_image.dart';
import 'location_chip.dart';
import 'availability_badge.dart';

/// Machinery listing card — used on the Home dashboard ("Nearby
/// Machinery") and the Discover screen (Stage 6).
/// Still takes plain fields rather than a Machinery object directly —
/// the Machinery model now exists (built ahead of this widget's use of
/// it), but keeping the card decoupled from the model type means it
/// can be reused later for any data source that isn't shaped like the
/// model (e.g. a future API response with different field names)
/// without changing this widget.
class MachineryCard extends StatelessWidget {
  final String name;
  final String provider;
  final String distanceLabel;
  final double pricePerDay;
  final bool isAvailable;
  final VoidCallback onViewDetails;

  const MachineryCard({
    super.key,
    required this.name,
    required this.provider,
    required this.distanceLabel,
    required this.pricePerDay,
    required this.isAvailable,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlaceholderImage(icon: Icons.agriculture),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Provider: $provider',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      LocationChip(label: distanceLabel),
                      const SizedBox(width: 12),
                      AvailabilityBadge(isAvailable: isAvailable),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${pricePerDay.toStringAsFixed(0)}/day',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      TextButton(
                        onPressed: onViewDetails,
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
