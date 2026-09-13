import 'package:flutter/material.dart';

enum PrimaryButtonVariant { filled, outlined }

/// Reusable button used across Login, Booking Request, and other CTAs.
/// Sizing/colors come from AppTheme's elevatedButtonTheme/outlinedButtonTheme
/// (see lib/theme/app_theme.dart) — this widget doesn't hardcode styling.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PrimaryButtonVariant.filled,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(label),
            ],
          );

    // Disable taps while a loading spinner is showing, so users can't
    // fire the same action twice (relevant later for booking submission).
    final VoidCallback? effectiveOnPressed = isLoading ? null : onPressed;

    if (variant == PrimaryButtonVariant.outlined) {
      return OutlinedButton(onPressed: effectiveOnPressed, child: child);
    }

    return ElevatedButton(onPressed: effectiveOnPressed, child: child);
  }
}
