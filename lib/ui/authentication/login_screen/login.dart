import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/divider_with_text.dart';
import '../forget_password_screen/forget_password_screen.dart';
import 'app_logo.dart';
import 'create_account_row.dart';
import 'language_toggle_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// --- Login Page Component ---
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      if (googleUser == null) return null;

      final googleAuth = googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;
    final double screenWidth = context.width;
    final localizations = AppLocalizations.of(context);
    final String currentLang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // --- Logo Header ---
              AppLogo(),
              SizedBox(height: screenHeight * 0.025),

              // --- Email Field ---
              CustomTextField(
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
              SizedBox(height: screenHeight * 0.02),

              // --- Password Field ---
              CustomTextField(
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
              SizedBox(height: screenHeight * 0.015),

              // --- Forget Password Navigation ---
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  ForgetPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    localizations?.forgetPassword ?? '',
                    style: AppTextStyles.bold14Yellow.copyWith(
                      fontSize: screenWidth * 0.033,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // --- Primary Login Button ---
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  backgroundColor: AppColors.yelloColor,
                  sideColor: AppColors.transparent,
                  redius: 15,
                  verticalPadding: 14,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
                  },
                  child: Text(
                    localizations?.login ?? '',
                    style: AppTextStyles.bold20Black,
                  ),
                ),
              )
              ,SizedBox(height: screenHeight * 0.025),

              // --- Create Account Row ---
              CreateAccountRow(),
              SizedBox(height: screenHeight * 0.03),

              // --- Divider ---
              DividerWithText(
                text: localizations?.or ?? '',
              ),
              SizedBox(height: screenHeight * 0.03),

              // --- Google Login Button ---
              CustomElevatedButton(
                backgroundColor: AppColors.yelloColor,
                sideColor: AppColors.transparent,
                redius: 15,
                verticalPadding: 14,
                onPressed: () async {
                  UserCredential? userCredential = await signInWithGoogle();
                  if (userCredential != null) {
                    Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.iconGoogle,
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      localizations?.loginWithGoogle ?? '',
                      style: AppTextStyles.bold20Black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.035),

              // --- Language Toggle Switch ---
              LanguageToggleSwitch(
                currentLanguage: currentLang,
                onLanguageChanged: (newLang) {
                  // TODO: Implement language state change logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}