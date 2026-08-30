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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<OnboardingModel> _getOnboardingList(AppLocalizations localizations) {
    return [
      OnboardingModel(
        imagePath: AppAssets.imageOnBoardingMain,
        title: localizations.titleMain,
        description: localizations.descMain,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.blackColor.withValues(alpha: 0.2),
            AppColors.blackColor.withValues(alpha: 0.9),
            AppColors.blackColor,
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      OnboardingModel(
        imagePath: AppAssets.imageOnBoarding1,
        title: localizations.titleOne,
        description: localizations.descOne,
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
        title: localizations.titleTwo,
        description: localizations.descTwo,
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
        title: localizations.titleThree,
        description: localizations.descThree,
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
        title: localizations.titleFour,
        description: localizations.descFour,
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
        title: localizations.titleFive,
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
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final onboardingList = _getOnboardingList(localizations);

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
              decoration: BoxDecoration(
                color: _currentIndex == 0
                    ? AppColors.transparent
                    : AppColors.blackColor,
                borderRadius: const BorderRadius.only(
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
                  if (onboardingList[_currentIndex].description != null &&
                      onboardingList[_currentIndex].description!.isNotEmpty) ...[
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
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.loginRouteName,
                        );
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
                          ? localizations.exploreNow
                          : _currentIndex == onboardingList.length - 1
                          ? localizations.finish
                          : localizations.next,
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
                        localizations.back,
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