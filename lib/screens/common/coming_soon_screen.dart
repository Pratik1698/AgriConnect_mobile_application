import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Generic placeholder destination for features not yet built
/// (Find Machinery, Find Professionals, Machinery/Professional Details,
/// etc). Reused across multiple tap targets instead of creating a
/// near-duplicate placeholder file for each one.
class ComingSoonScreen extends StatelessWidget {
  final String title;
  final String message;

  const ComingSoonScreen({
    super.key,
    required this.title,
    this.message = 'This screen will be available in an upcoming stage.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.construction_outlined,
                size: 56,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
