import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Center(
              child: Image.asset(
                AppAssets.imageSplashScreen,
              ),
            ),
            const Spacer(flex: 2),
            Image.asset(
              AppAssets.imageRouteLogo,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}