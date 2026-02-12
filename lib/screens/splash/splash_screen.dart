import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// Initialize notifications
    NotificationService().init();

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      /// Go directly to Home
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_laundry_service,
              size: 100,
              color: AppColors.white,
            ),
            const SizedBox(height: 24),

            const Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              AppStrings.appTagline,
              style: TextStyle(fontSize: 16, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
