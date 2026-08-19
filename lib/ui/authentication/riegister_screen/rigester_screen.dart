import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../login_screen/language_toggle_switch.dart';
import 'avatar_selector.dart';

// --- Register Screen Component ---
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Responsive Dimensions & Localizations ---
    final double screenHeight = context.height;
    final double screenWidth = context.width;
    final localizations = AppLocalizations.of(context);
    final String currentLang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: AppColors.blackColor,

      // --- App Bar ---
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.yelloColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations?.register ?? '',
          style: AppTextStyles.bold20Yellow.copyWith(
            fontSize: screenWidth * 0.045,
          ),
        ),
        centerTitle: true,
      ),

      // --- Body ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.015,
          ),
          child: Column(
            children: [
              // --- Avatar Selector ---
              AvatarSelector(),
              SizedBox(height: screenHeight * 0.025),

              // --- Name Field ---
              CustomTextField(
                hintText: localizations?.name ?? '',
                hintStyle: AppTextStyles.regular16White,
                fillColor: AppColors.grayColor,
                borderColor: AppColors.transparent,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.iconName),
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.018),

              // --- Email Field ---
              CustomTextField(
                textStyle: AppTextStyles.regular16White,

                hintText: localizations?.email ?? '',
                hintStyle: AppTextStyles.regular16White,
                fillColor: AppColors.grayColor,
                borderColor: AppColors.transparent,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.iconMail),
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.018),

              // --- Password Field ---
              CustomTextField(
                textStyle: AppTextStyles.regular16White,

                hintText: localizations?.password ?? '',
                hintStyle: AppTextStyles.regular16White,
                fillColor: AppColors.grayColor,
                borderColor: AppColors.transparent,
                obscureText: true,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.iconPass),
                  color: AppColors.whiteColor,
                ),
                suffixIcon: ImageIcon(
                  AssetImage(AppAssets.iconEyeOff),
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.018),

              // --- Confirm Password Field ---
              CustomTextField(
                textStyle: AppTextStyles.regular16White,

                hintText: localizations?.confirmPassword ?? '',
                hintStyle: AppTextStyles.regular16White,
                fillColor: AppColors.grayColor,
                borderColor: AppColors.transparent,
                obscureText: true,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.iconPass),
                  color: AppColors.whiteColor,
                ),
                suffixIcon: ImageIcon(
                  AssetImage(AppAssets.iconEyeOff),
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.018),

              // --- Phone Number Field ---
              CustomTextField(
                textStyle: AppTextStyles.regular16White,

                hintText: localizations?.phoneNumber ?? '',
                hintStyle: AppTextStyles.regular16White,
                fillColor: AppColors.grayColor,
                borderColor: AppColors.transparent,
                keyboardType: TextInputType.phone,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.iconPhone),
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // --- Create Account Action Button ---
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  backgroundColor: AppColors.yelloColor,
                  sideColor: AppColors.transparent,
                  redius: 15,
                  verticalPadding: 14,
                  onPressed: () {
                    // TODO: Implement registration logic
                    Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);

                  },
                  child: Text(
                    localizations?.createAccount ?? '',
                    style: AppTextStyles.bold20Black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // --- Already Have Account Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations?.alreadyHaveAccount ?? '',
                    style: AppTextStyles.regular16White.copyWith(
                      fontSize: screenWidth * 0.033,
                      color: AppColors.whiteColor.withValues(alpha: 0.8),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      localizations?.login ?? '',
                      style: AppTextStyles.bold14Yellow.copyWith(
                        fontSize: screenWidth * 0.033,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              // --- Language Toggle Switch ---
              LanguageToggleSwitch(
                currentLanguage: currentLang,
                onLanguageChanged: (newLang) {
                  // TODO: Implement language state change logic
                },
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
