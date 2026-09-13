import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../mock/farmer_mock_data.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/machinery_card.dart';
import '../../widgets/professional_card.dart';
import '../common/coming_soon_screen.dart';

enum _DiscoverCategory { machinery, professionals }

/// Discover tab — Stage 6.
///
/// Browse machinery and professionals from mock data, filtered by a
/// category toggle and live text search. Card tap does NOT open a real
/// detail screen yet — that's Stage 7 (Detail + Book), scoped
/// separately on purpose so this stage stays focused on browsing.
///
/// Distance shown on each card is a static mock label (e.g. "8.2 km"),
/// not a live GPS calculation — location permissions and PostGIS-backed
/// distance sorting are a separate, later capability not built yet.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  _DiscoverCategory _category = _DiscoverCategory.machinery;
  String _query = '';

  void _openComingSoon(String title) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => ComingSoonScreen(title: title)));
  }

  void _onCategoryChanged(_DiscoverCategory category) {
    // Query is cleared on switch — a search term typed under "Machinery"
    // silently carrying over to "Professionals" would be confusing,
    // especially for a first-time or low-literacy user.
    setState(() {
      _category = category;
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMachinery = _category == _DiscoverCategory.machinery;
    final String query = _query.toLowerCase();

    final List<Widget> cards;
    if (isMachinery) {
      final results = FarmerMockData.nearbyMachinery.where((m) {
        return m.name.toLowerCase().contains(query) ||
            m.provider.toLowerCase().contains(query);
      }).toList();

      cards = results
          .map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MachineryCard(
                name: m.name,
                provider: m.provider,
                distanceLabel: m.distanceLabel,
                pricePerDay: m.pricePerDay,
                isAvailable: m.isAvailable,
                onViewDetails: () => _openComingSoon('Machinery Details'),
              ),
            ),
          )
          .toList();
    } else {
      final results = FarmerMockData.nearbyProfessionals.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.specialization.toLowerCase().contains(query);
      }).toList();

      cards = results
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProfessionalCard(
                name: p.name,
                specialization: p.specialization,
                distanceLabel: p.distanceLabel,
                rating: p.rating,
                isAvailable: p.isAvailable,
                onViewProfile: () => _openComingSoon('Professional Details'),
              ),
            ),
          )
          .toList();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Discover',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _CategoryToggle(
                selected: _category,
                onChanged: _onCategoryChanged,
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppSearchBar(
                // Keyed by category so switching tabs creates a fresh
                // TextField instance — otherwise the visible text would
                // stay on screen even after _query resets, since
                // TextField owns its own internal editing state when no
                // controller is passed in.
                key: ValueKey(_category),
                hintText: isMachinery
                    ? 'Search machinery...'
                    : 'Search professionals...',
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: cards.isEmpty
                  ? const _EmptyResults()
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      children: cards,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Machinery/Professionals segmented toggle — kept private to this
/// screen until a second screen genuinely needs it, matching the same
/// convention already used for _QuickActionsRow in FarmerHomeScreen.
class _CategoryToggle extends StatelessWidget {
  final _DiscoverCategory selected;
  final ValueChanged<_DiscoverCategory> onChanged;

  const _CategoryToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: 'Machinery',
            isSelected: selected == _DiscoverCategory.machinery,
            onTap: () => onChanged(_DiscoverCategory.machinery),
          ),
          _ToggleOption(
            label: 'Professionals',
            isSelected: selected == _DiscoverCategory.professionals,
            onTap: () => onChanged(_DiscoverCategory.professionals),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? AppColors.textOnPrimary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Shown when search/filter returns no results — replaces a blank
/// screen with a clear message (Stage 6 acceptance criteria #4).
class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off,
              size: 56,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term, or check back later for more listings nearby.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
