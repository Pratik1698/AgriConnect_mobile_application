import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';

/// Splash screen shown on app launch.
/// After a short delay, navigates automatically to Login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    // Lifecycle-safe delayed navigation: cancelled in dispose() so it
    // never fires (and never touches a disposed context) if the user
    // backgrounds or closes the app during the delay.
    _navigationTimer = Timer(const Duration(seconds: 2), _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoftBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.agriculture,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'AgriConnect',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Connecting Farmers to Agricultural Services',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
