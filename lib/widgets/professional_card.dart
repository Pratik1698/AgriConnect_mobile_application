import 'package:flutter/material.dart';

import 'placeholder_image.dart';
import 'location_chip.dart';
import 'rating_widget.dart';
import 'availability_badge.dart';

/// Professional listing card — used on Dashboard ("Nearby Professionals")
/// and the Find Professionals screen (Stage 10/11).
class ProfessionalCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String distanceLabel;
  final double rating;
  final bool isAvailable;
  final VoidCallback onViewProfile;

  const ProfessionalCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.distanceLabel,
    required this.rating,
    required this.isAvailable,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlaceholderImage(
              icon: Icons.person,
              size: 56,
              borderRadius: 28,
            ),
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
                    specialization,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      LocationChip(label: distanceLabel),
                      const SizedBox(width: 12),
                      RatingWidget(rating: rating),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvailabilityBadge(isAvailable: isAvailable),
                      TextButton(
                        onPressed: onViewProfile,
                        child: const Text('View Profile'),
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
