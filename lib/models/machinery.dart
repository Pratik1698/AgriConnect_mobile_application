/// Minimal machinery model for dashboard/list display.
/// Intentionally lean for now — fields like brand, model, and machine
/// type are added in Stage 7 (Machinery Details) when they're actually
/// needed, rather than speculatively now.
class Machinery {
  final String name;
  final String provider;
  final String distanceLabel;
  final double pricePerDay;
  final bool isAvailable;

  const Machinery({
    required this.name,
    required this.provider,
    required this.distanceLabel,
    required this.pricePerDay,
    required this.isAvailable,
  });
}
