import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_utils.dart';

class LanguageToggleSwitch extends StatelessWidget {
  final String? currentLanguage;
  final Function(String)? onLanguageChanged;

  const LanguageToggleSwitch({
    super.key,
    this.currentLanguage,
    this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = context.width;
    final String activeLang =
        currentLanguage ?? Localizations.localeOf(context).languageCode;
    final bool isEnglish = activeLang == 'en';

    // --- UI Structure ---
    return Container(
      width: screenWidth * 0.28,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.yelloColor, width: 2.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- English Option ---
          GestureDetector(
            onTap: () => onLanguageChanged?.call('en'),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isEnglish
                    ? AppColors.yelloColor
                    : AppColors.transparent,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.iconAmerican,
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // --- Arabic Option ---
          GestureDetector(
            onTap: () => onLanguageChanged?.call('ar'),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: !isEnglish
                    ? AppColors.yelloColor
                    : AppColors.transparent,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.iconEgypt,
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}