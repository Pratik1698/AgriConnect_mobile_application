import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../farmer/farmer_app_shell.dart';

/// Login screen — UI + validation only.
/// Real authentication is connected in a later stage (Stage 13).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) {
      return 'Mobile number is required';
    }
    final cleaned = trimmed.replaceAll(RegExp(r'\s+'), '');
    final regex = RegExp(r'^(?:\+91|91|0)?[6-9]\d{9}$');
    if (!regex.hasMatch(cleaned)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void _handleLogin() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSubmitting = true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Real authentication will be connected in a later stage. '
            'Use "Continue with Demo Account" to explore the app.',
          ),
        ),
      );
    });
  }

  void _handleDemoLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const FarmerAppShell()));
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature will be available in a later stage.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.primarySoftBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.agriculture,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome to AgriConnect',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Log in to find machinery, professionals, and more',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),

                Text(
                  'Mobile Number',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: _validateMobile,
                  decoration: const InputDecoration(
                    hintText: 'Enter your mobile number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 20),

                Text('Password', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                  onFieldSubmitted: (_) => _handleLogin(),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _showComingSoon('Forgot Password'),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 16),

                PrimaryButton(
                  label: 'Login',
                  onPressed: _handleLogin,
                  isLoading: _isSubmitting,
                ),
                const SizedBox(height: 12),

                PrimaryButton(
                  label: 'Continue with Demo Account',
                  variant: PrimaryButtonVariant.outlined,
                  icon: Icons.play_circle_outline,
                  onPressed: _handleDemoLogin,
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () => _showComingSoon('Create Account'),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
