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

    final double switchWidth = screenWidth * 0.28;
    const double switchHeight = 48.0;

    return Container(
      width: switchWidth,
      height: switchHeight,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.yelloColor, width: 2.5),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            alignment: isEnglish ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: switchHeight - 13,
              height: switchHeight - 13,
              decoration: const BoxDecoration(
                color: AppColors.yelloColor,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onLanguageChanged?.call('en'),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(2),
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
              GestureDetector(
                onTap: () => onLanguageChanged?.call('ar'),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(2),
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
        ],
      ),
    );
  }
}