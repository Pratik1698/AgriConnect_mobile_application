import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

/// Root widget of the AgriConnect app.
///
/// Kept separate from main.dart so app-level config (theme, routes,
/// localization delegates later) lives in exactly one place.
class AgriConnectApp extends StatelessWidget {
  const AgriConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Stage 1 has only one screen, so we route via `home`.
      // From Stage 4 onward (Login → Dashboard), we'll switch this to
      // named routes so navigation stays centralized and readable.
      home: const SplashScreen(),
    );
  }
}
