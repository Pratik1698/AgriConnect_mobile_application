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
