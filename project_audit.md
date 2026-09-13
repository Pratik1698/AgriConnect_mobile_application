# Project Audit: agri_connect

**Audit Timestamp:** 2026-09-12  
**Operating System:** Windows  
**Audit Scope:** Read-only inspection of the `agri_connect` Flutter project.

---

## 1. `flutter analyze` Output

```
Analyzing agri_connect...                                       
No issues found! (ran in 3.3s)
```

---

## 2. Directory Tree of `lib/`

```
lib/
├── app.dart
├── localization/                    [empty directory]
├── main.dart
├── mock/
│   └── farmer_mock_data.dart
├── models/
│   ├── machinery.dart
│   └── professional.dart
├── screens/
│   ├── auth/
│   │   └── login_screen.dart
│   ├── common/
│   │   └── coming_soon_screen.dart
│   ├── farmer/
│   │   ├── bookings_screen.dart
│   │   ├── discover_screen.dart
│   │   ├── farmer_app_shell.dart
│   │   ├── farmer_home_screen.dart
│   │   └── profile_screen.dart
│   └── splash/
│       └── splash_screen.dart
├── theme/
│   └── app_theme.dart
└── widgets/
    ├── app_header.dart
    ├── app_search_bar.dart
    ├── location_chip.dart
    ├── machinery_card.dart
    ├── placeholder_image.dart
    ├── primary_button.dart
    ├── professional_card.dart
    ├── rating_widget.dart
    ├── section_header.dart
    └── status_badge.dart
```

Total files in `lib/`: 18 Dart files across 6 top-level directories and 4 screen subdirectories.

---

## 3. Complete File Contents

All files were located without guessing:
- `FarmerAppShell` was found at `lib/screens/farmer/farmer_app_shell.dart`.
- `ComingSoonScreen` was found at `lib/screens/common/coming_soon_screen.dart`.
- All other 9 files matched their paths exactly.

### File: `D:/FlutterProjects/agri_connect/lib/models/machinery.dart`

```dart
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
```

---

### File: `D:/FlutterProjects/agri_connect/lib/models/professional.dart`

```dart
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
```

---

### File: `D:/FlutterProjects/agri_connect/lib/mock/farmer_mock_data.dart`

```dart
import '../models/machinery.dart';
import '../models/professional.dart';

/// Mock data for the Farmer Dashboard.
/// Deliberately isolated from UI code so it can be swapped for a real
/// REST API repository later (Stage 13) without touching any screen.
class FarmerMockData {
  FarmerMockData._();

  static const List<Machinery> nearbyMachinery = [
    Machinery(
      name: 'Mahindra Tractor',
      provider: 'Demo Provider',
      distanceLabel: '8.2 km',
      pricePerDay: 2500,
      isAvailable: true,
    ),
    Machinery(
      name: 'Rotavator',
      provider: 'Demo Provider',
      distanceLabel: '5.4 km',
      pricePerDay: 1800,
      isAvailable: true,
    ),
    Machinery(
      name: 'Harvester',
      provider: 'Demo Provider',
      distanceLabel: '11.2 km',
      pricePerDay: 4500,
      isAvailable: false,
    ),
  ];

  static const List<Professional> nearbyProfessionals = [
    Professional(
      name: 'Omkar Magdum',
      specialization: 'Agronomist',
      distanceLabel: '6.4 km',
      rating: 4.8,
      isAvailable: true,
    ),
    Professional(
      name: 'Shreyash Kashid',
      specialization: 'Organic Farming',
      distanceLabel: '8.1 km',
      rating: 4.7,
      isAvailable: true,
    ),
    Professional(
      name: 'Soil Expert',
      specialization: 'Demo Professional',
      distanceLabel: '10.2 km',
      rating: 4.5,
      isAvailable: false,
    ),
  ];
}
```

---

### File: `D:/FlutterProjects/agri_connect/lib/screens/farmer/farmer_app_shell.dart`

```dart
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'farmer_home_screen.dart';
import 'discover_screen.dart';
import 'bookings_screen.dart';
import 'profile_screen.dart';

/// Main app shell shown after login: persistent bottom navigation with
/// 4 tabs. Uses IndexedStack so switching tabs preserves each screen's
/// state and never pushes a new screen onto the navigation stack —
/// this is what prevents duplicate dashboard instances on back nav.
class FarmerAppShell extends StatefulWidget {
  const FarmerAppShell({super.key});

  @override
  State<FarmerAppShell> createState() => _FarmerAppShellState();
}

class _FarmerAppShellState extends State<FarmerAppShell> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      FarmerHomeScreen(onNavigateToTab: _onTabSelected),
      const DiscoverScreen(),
      const BookingsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            activeIcon: Icon(Icons.event_note),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

---

### File: `D:/FlutterProjects/agri_connect/lib/screens/common/coming_soon_screen.dart`

```dart
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
```

---

### File: `D:/FlutterProjects/agri_connect/lib/widgets/machinery_card.dart`

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'placeholder_image.dart';
import 'location_chip.dart';

/// Machinery listing card — used on Dashboard ("Nearby Machinery")
/// and the Find Machinery screen (Stage 4/6).
/// Takes plain fields (not a Machinery model) since the model is
/// scheduled for Stage 4 — avoids coupling this widget to code that
/// doesn't exist yet.
class MachineryCard extends StatelessWidget {
  final String name;
  final String provider;
  final String distanceLabel;
  final double pricePerDay;
  final bool isAvailable;
  final VoidCallback onViewDetails;

  const MachineryCard({
    super.key,
    required this.name,
    required this.provider,
    required this.distanceLabel,
    required this.pricePerDay,
    required this.isAvailable,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlaceholderImage(icon: Icons.agriculture),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Provider: $provider',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      LocationChip(label: distanceLabel),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: isAvailable
                            ? AppColors.success
                            : AppColors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isAvailable ? 'Available' : 'Unavailable',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isAvailable
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${pricePerDay.toStringAsFixed(0)}/day',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      TextButton(
                        onPressed: onViewDetails,
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### File: `D:/FlutterProjects/agri_connect/lib/widgets/professional_card.dart`

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'placeholder_image.dart';
import 'location_chip.dart';
import 'rating_widget.dart';

/// Professional listing card — used on Dashboard ("Nearby Professionals")
/// and the Find Professionals screen (Stage 10/11).
class ProfessionalCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String distanceLabel;
  final double rating;
  final bool isAvailable;
  final VoidCallback onViewProfile;

  const ProfessionalCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.distanceLabel,
    required this.rating,
    required this.isAvailable,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlaceholderImage(
              icon: Icons.person,
              size: 56,
              borderRadius: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specialization,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      LocationChip(label: distanceLabel),
                      const SizedBox(width: 12),
                      RatingWidget(rating: rating),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: isAvailable
                                ? AppColors.success
                                : AppColors.error,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isAvailable ? 'Available' : 'Unavailable',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isAvailable
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: onViewProfile,
                        child: const Text('View Profile'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### File: `D:/FlutterProjects/agri_connect/lib/widgets/app_search_bar.dart`

```dart
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
```

---

### File: `D:/FlutterProjects/agri_connect/lib/widgets/location_chip.dart`

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Small inline label with a pin icon — used for distance ("8.2 km")
/// and general location text throughout cards and headers.
class LocationChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const LocationChip({
    super.key,
    required this.label,
    this.icon = Icons.location_on_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
```

---

### File: `D:/FlutterProjects/agri_connect/lib/widgets/rating_widget.dart`

```dart
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
```

---

### File: `D:/FlutterProjects/agri_connect/lib/widgets/status_badge.dart`

```dart
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
```

---

## 4. Short List of Audit Flags

### 4.1 Unused / Dead Code
- **`farmer_dashboard.dart`**: **DOES NOT EXIST** anywhere in the project. The dashboard is implemented as `FarmerHomeScreen` (`lib/screens/farmer/farmer_home_screen.dart`), embedded inside `FarmerAppShell` (`lib/screens/farmer/farmer_app_shell.dart`).
- **`lib/widgets/status_badge.dart` (`StatusBadge` & `BookingStatus`)**: Entire file is unreferenced. Neither `StatusBadge` nor `BookingStatus` is imported or used by any screen or widget in `lib/`. (Prepared in advance for Stage 9 booking statuses).
- **`AppColors.warning`** (`lib/theme/app_theme.dart:32`): Declared (`Color(0xFFF9A825)`) but never referenced in any file.
- **`AppColors.primaryLight`** (`lib/theme/app_theme.dart:14`): Declared (`Color(0xFFA5D6A7)`) but never referenced in any file.
- **`lib/localization/` directory**: Empty folder on disk containing 0 files.

### 4.2 Files with TODO, FIXME, or Placeholder Comments
- **TODO / FIXME**: 0 occurrences across the entire project.
- **Placeholder comments / Stage deferred comments found in 10 files**:
  1. `lib/screens/farmer/bookings_screen.dart` (line 5):
     `/// Placeholder Bookings tab. Full booking history with status tabs (All/Pending/Accepted/Completed/Cancelled) is built in Stage 9.`
  2. `lib/screens/farmer/discover_screen.dart` (line 5):
     `/// Placeholder Discover tab. Full discovery experience (browsing machinery/professionals by category, filters, map view) is a future stage — not built yet.`
  3. `lib/screens/farmer/profile_screen.dart` (line 5):
     `/// Placeholder Profile tab. Profile editing, farm details, and settings are future stages — not built yet.`
  4. `lib/screens/common/coming_soon_screen.dart` (lines 5–8):
     `/// Generic placeholder destination for features not yet built (Find Machinery, Find Professionals, Machinery/Professional Details, etc). Reused across multiple tap targets instead of creating a near-duplicate placeholder file for each one.`
  5. `lib/widgets/placeholder_image.dart` (lines 5–8):
     `/// Shared image placeholder for machinery/professional cards. Replace with real network/asset images once provider photos exist...`
  6. `lib/models/machinery.dart` (lines 2–4):
     `/// Intentionally lean for now — fields like brand, model, and machine type are added in Stage 7 (Machinery Details) when they're actually needed, rather than speculatively now.`
  7. `lib/models/professional.dart` (lines 2–3):
     `/// Extended later (Stage 11 — Professional Details) with fields like experience, services offered, and verification status.`
  8. `lib/mock/farmer_mock_data.dart` (lines 5–6):
     `/// Deliberately isolated from UI code so it can be swapped for a real REST API repository later (Stage 13) without touching any screen.`
  9. `lib/screens/auth/login_screen.dart` (lines 8 & 63):
     `/// Real authentication is connected in a later stage (Stage 13).`
  10. `lib/app.dart` (lines 19–21):
      `// Stage 1 has only one screen, so we route via home. From Stage 4 onward (Login → Dashboard), we'll switch this to named routes...`

### 4.3 Use of `dynamic` Typing in Models
- **Zero occurrences.** Neither `lib/models/machinery.dart` nor `lib/models/professional.dart` uses `dynamic`. All properties are strictly typed (`String`, `double`, `bool`).
- Furthermore, there is zero use of `dynamic` across the entire `lib/` codebase.

### 4.4 Duplicated Widgets or Logic Across Files
1. **Available/Unavailable status indicator (Identical duplication):**
   - In `lib/widgets/machinery_card.dart` (lines 62–79) and `lib/widgets/professional_card.dart` (lines 73–90):
     Both widgets use identical layout, styling, and color logic for the circular status bullet and text:
     ```dart
     Icon(
       Icons.circle,
       size: 8,
       color: isAvailable ? AppColors.success : AppColors.error,
     ),
     const SizedBox(width: 4),
     Text(
       isAvailable ? 'Available' : 'Unavailable',
       style: TextStyle(
         fontSize: 12,
         fontWeight: FontWeight.w600,
         color: isAvailable ? AppColors.success : AppColors.error,
       ),
     ),
     ```
     *Recommendation:* Can be extracted into a shared `AvailabilityChip` or `AvailabilityBadge` widget in `lib/widgets/`.

2. **Circular Logo Badge (Brand Header Icon):**
   - In `lib/screens/splash/splash_screen.dart` (lines 53–64) and `lib/screens/auth/login_screen.dart` (lines 95–106):
     Both build a circular container with `AppColors.primarySoftBackground` and `Icons.agriculture` in `AppColors.primary`, differing only in diameter (64 vs 48) and padding (20 vs 16).
     *Recommendation:* Could be consolidated into an `AppLogo` widget.

3. **Placeholder Screen UI Pattern:**
   - `lib/screens/farmer/bookings_screen.dart`, `lib/screens/farmer/discover_screen.dart`, and `lib/screens/farmer/profile_screen.dart` all repeat the exact same layout structure (Scaffold, SafeArea, Padding 20, headlineMedium header, Expanded Center with a 56px primary icon and title/subtitle). This directly duplicates the pattern of `ComingSoonScreen` (`lib/screens/common/coming_soon_screen.dart`).

4. **"Feature in later stage" transient feedback:**
   - In `lib/screens/farmer/farmer_home_screen.dart` (`_handleSearchTap`) and `lib/screens/auth/login_screen.dart` (`_showComingSoon`):
     Both construct inline `SnackBar` notifications with hardcoded `"will be available in a later stage."` messaging.
