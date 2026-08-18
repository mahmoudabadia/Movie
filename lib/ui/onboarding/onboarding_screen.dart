import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_routes.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import 'onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  late final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      imagePath: AppAssets.imageOnBoardingMain,
      title: AppLocalizations.of(context)!.titleMain,
      description: AppLocalizations.of(context)!.descMain,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.blackColor.withValues(alpha: 0.2),
          AppColors.blackColor.withValues(alpha: 0.8),
          AppColors.blackColor,
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      imagePath: AppAssets.imageOnBoarding1,
      title: AppLocalizations.of(context)!.titleOne,
      description: AppLocalizations.of(context)!.descOne,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.withValues(alpha: 0.2),
          AppColors.blackColor.withValues(alpha: 0.8),
          AppColors.blackColor,
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      imagePath: AppAssets.imageOnBoarding2,
      title: AppLocalizations.of(context)!.titleTwo,
      description: AppLocalizations.of(context)!.descTwo,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.redColor.withValues(alpha: 0.2),
          AppColors.blackColor.withValues(alpha: 0.8),
          AppColors.blackColor,
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      imagePath: AppAssets.imageOnBoarding3,
      title: AppLocalizations.of(context)!.titleThree,
      description: AppLocalizations.of(context)!.descThree,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.purple.withValues(alpha: 0.2),
          AppColors.blackColor.withValues(alpha: 0.8),
          AppColors.blackColor,
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      imagePath: AppAssets.imageOnBoarding4,
      title: AppLocalizations.of(context)!.titleFour,
      description: AppLocalizations.of(context)!.descFour,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepOrangeAccent.withValues(alpha: 0.2),
          AppColors.blackColor.withValues(alpha: 0.8),
          AppColors.blackColor,
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      imagePath: AppAssets.imageOnBoarding5,
      title: AppLocalizations.of(context)!.titleFive,
      description: '',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.grayColor.withValues(alpha: 0.9),
          AppColors.blackColor.withValues(alpha: 0.6),
          AppColors.blackColor,
        ],
        stops: const [0.0, 0.6, 1.0],
      ),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingList.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    onboardingList[index].imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: onboardingList[index].gradient,
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    onboardingList[_currentIndex].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold24White,
                  ),
                  if (onboardingList[_currentIndex].description != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      onboardingList[_currentIndex].description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < onboardingList.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);


                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yelloColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentIndex == 0
                          ? AppLocalizations.of(context)!.exploreNow
                          : _currentIndex == onboardingList.length - 1
                          ? AppLocalizations.of(context)!.finish
                          : AppLocalizations.of(context)!.next,
                      style: AppTextStyles.semiBold20Black,
                    ),
                  ),
                  if (_currentIndex > 0) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.yelloColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.back,
                        style: AppTextStyles.bold14Yellow,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}