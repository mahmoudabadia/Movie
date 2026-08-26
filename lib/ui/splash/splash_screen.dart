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

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouteName);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 240),
          Center(
            child: Image.asset( AppAssets.imageSplashScreen

            ),
          ),
          const SizedBox(height: 120),
          Image.asset(AppAssets.imageRouteLogo),
        ],
      ),
    );
  }
}