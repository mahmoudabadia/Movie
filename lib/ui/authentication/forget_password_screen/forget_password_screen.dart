import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

// --- Screen Declaration ---
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // --- Screen Dimensions & Localizations ---
    final double screenHeight = context.height;
    final double screenWidth = context.width;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.blackColor,

      // --- App Bar ---
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.yelloColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations?.forgetPasswordTitle ?? '',
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
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // --- Illustration Image ---
              Image.asset(
                AppAssets.imageForgetPass,
                height: screenHeight * 0.35,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: screenWidth * 0.2,
                      color: AppColors.yelloColor,
                    ),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.04),

              // --- Email Form Field ---
              CustomTextField(
                controller: emailController,
                hintText: localizations?.email ?? '',
                hintStyle: AppTextStyles.regular16White,
                fillColor: AppColors.grayColor,
                borderColor: AppColors.transparent,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const ImageIcon(
                  AssetImage(AppAssets.iconMail),
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // --- Action Button ---
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  backgroundColor: AppColors.yelloColor,
                  sideColor: AppColors.transparent,
                  redius: 15,
                  verticalPadding: 14,
                  onPressed: () async {
                    if (emailController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your email')),
                      );
                      return;
                    }

                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim(),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password reset link sent! Check your email.'),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  child: Text(
                    localizations?.verifyEmail ?? '',
                    style: AppTextStyles.bold20Black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}