import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/section_header.dart';
import '../../widgets/machinery_card.dart';
import '../../widgets/professional_card.dart';
import '../../mock/farmer_mock_data.dart';
import '../common/coming_soon_screen.dart';

/// Real Farmer Dashboard — the Home tab of the Farmer App Shell.
/// [onNavigateToTab] lets Quick Actions (e.g. "My Bookings") switch
/// the shell's active tab instead of pushing a new screen.
class FarmerHomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigateToTab;

  const FarmerHomeScreen({super.key, required this.onNavigateToTab});

  void _openComingSoon(BuildContext context, String title) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => ComingSoonScreen(title: title)));
  }

  void _handleSearchTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Search will be available in a later stage.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            AppHeader(
              greeting: 'Good Morning, Farmer 👋',
              locationLabel: 'Current Location',
              onProfileTap: () => onNavigateToTab(3),
            ),
            const SizedBox(height: 20),

            AppSearchBar(
              hintText: 'What service do you need?',
              onTap: () => _handleSearchTap(context),
            ),
            const SizedBox(height: 24),

            _QuickActionsRow(
              onFindMachinery: () => _openComingSoon(context, 'Find Machinery'),
              onFindProfessionals: () =>
                  _openComingSoon(context, 'Find Professionals'),
              onMyBookings: () => onNavigateToTab(2),
            ),
            const SizedBox(height: 28),

            SectionHeader(
              title: 'Nearby Machinery',
              actionLabel: 'View All',
              onActionTap: () => _openComingSoon(context, 'Find Machinery'),
            ),
            const SizedBox(height: 12),
            ...FarmerMockData.nearbyMachinery.map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MachineryCard(
                  name: m.name,
                  provider: m.provider,
                  distanceLabel: m.distanceLabel,
                  pricePerDay: m.pricePerDay,
                  isAvailable: m.isAvailable,
                  onViewDetails: () =>
                      _openComingSoon(context, 'Machinery Details'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SectionHeader(
              title: 'Nearby Professionals',
              actionLabel: 'View All',
              onActionTap: () => _openComingSoon(context, 'Find Professionals'),
            ),
            const SizedBox(height: 12),
            ...FarmerMockData.nearbyProfessionals.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ProfessionalCard(
                  name: p.name,
                  specialization: p.specialization,
                  distanceLabel: p.distanceLabel,
                  rating: p.rating,
                  isAvailable: p.isAvailable,
                  onViewProfile: () =>
                      _openComingSoon(context, 'Professional Details'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Private helper widget — only used within this screen, so it's kept
/// local rather than promoted to lib/widgets/ until a second screen
/// genuinely needs it (avoids premature reuse abstraction).
class _QuickActionsRow extends StatelessWidget {
  final VoidCallback onFindMachinery;
  final VoidCallback onFindProfessionals;
  final VoidCallback onMyBookings;

  const _QuickActionsRow({
    required this.onFindMachinery,
    required this.onFindProfessionals,
    required this.onMyBookings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuickActionButton(
          icon: Icons.agriculture,
          label: 'Find Machinery',
          onTap: onFindMachinery,
        ),
        const SizedBox(width: 12),
        _QuickActionButton(
          icon: Icons.engineering,
          label: 'Find Professionals',
          onTap: onFindProfessionals,
        ),
        const SizedBox(width: 12),
        _QuickActionButton(
          icon: Icons.event_note,
          label: 'My Bookings',
          onTap: onMyBookings,
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.primarySoftBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
