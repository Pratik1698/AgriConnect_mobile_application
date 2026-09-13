import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Placeholder Bookings tab. Full booking history with status tabs
/// (All/Pending/Accepted/Completed/Cancelled) is built in Stage 9.
class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Bookings',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.event_note_outlined,
                          size: 56,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your bookings will appear here.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
