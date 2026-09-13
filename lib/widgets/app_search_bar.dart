import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Reusable search field. If [onTap] is provided, the field becomes
/// read-only and acts like a button (tapping navigates to a dedicated
/// search screen) instead of opening the keyboard in place — this is
/// the pattern used for the Dashboard's "What service do you need?" bar.
class AppSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const AppSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool actsAsButton = onTap != null;

    return TextField(
      readOnly: actsAsButton,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
