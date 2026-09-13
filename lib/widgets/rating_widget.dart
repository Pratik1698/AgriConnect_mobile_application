import 'package:flutter/material.dart';

/// Star rating display — e.g. ★ 4.5 (23)
class RatingWidget extends StatelessWidget {
  final double rating;
  final int? reviewCount;

  const RatingWidget({super.key, required this.rating, this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFA726)),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}
