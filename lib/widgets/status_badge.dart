import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Stable internal booking status values.
/// Per project rules: NEVER rename or translate these enum values.
/// Only the displayed label (see _label below) changes with localization.
enum BookingStatus { pending, accepted, completed, cancelled }

class StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const StatusBadge({super.key, required this.status});

  Color get _color {
    switch (status) {
      case BookingStatus.pending:
        return AppColors.pending;
      case BookingStatus.accepted:
        return AppColors.primary;
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }

  String get _label {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.accepted:
        return 'Accepted';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: _color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
