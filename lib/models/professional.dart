/// Minimal professional model for dashboard/list display.
/// Extended later (Stage 11 — Professional Details) with fields like
/// experience, services offered, and verification status.
class Professional {
  final String name;
  final String specialization;
  final String distanceLabel;
  final double rating;
  final bool isAvailable;

  const Professional({
    required this.name,
    required this.specialization,
    required this.distanceLabel,
    required this.rating,
    required this.isAvailable,
  });
}
