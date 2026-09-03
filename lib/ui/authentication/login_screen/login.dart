import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/dialog_utilis.dart';
import '../../../utils/size_utils.dart';
import '../../cubit/cubit_language.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/divider_with_text.dart';
import '../../widgets/snakbar_widget.dart';
import '../forget_password_screen/forget_password_screen.dart';
import 'app_logo.dart';
import 'create_account_row.dart';
import 'language_toggle_switch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isLoading = false;

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.03),

                AppLogo(),
                SizedBox(height: screenHeight * 0.025),

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
                  controller: emailController,
                ),
                SizedBox(height: screenHeight * 0.02),

                CustomTextField(
                  textStyle: AppTextStyles.regular16White,
                  controller: passController,
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

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
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

                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    backgroundColor: AppColors.yelloColor,
                    sideColor: AppColors.transparent,
                    redius: 15,
                    verticalPadding: 14,
                    onPressed: isLoading
                        ? () {}
                        : () {
                            if (formKey.currentState?.validate() ?? true) {
                              login();
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.blackColor,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            localizations?.login ?? '',
                            style: AppTextStyles.bold20Black,
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),

                CreateAccountRow(),
                SizedBox(height: screenHeight * 0.03),

                DividerWithText(text: localizations?.or ?? ''),
                SizedBox(height: screenHeight * 0.03),

                CustomElevatedButton(
                  backgroundColor: AppColors.yelloColor,
                  sideColor: AppColors.transparent,
                  redius: 15,
                  verticalPadding: 14,
                  onPressed: () async {
                    UserCredential? userCredential = await signInWithGoogle();
                    if (userCredential != null) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.homeRouteName,
                      );

                      showSnackBar(
                        AppLocalizations.of(context)!.loginSuccess,
                        context,
                        isError: false,
                      );
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

                LanguageToggleSwitch(
                  currentLanguage: currentLang,
                  onLanguageChanged: (newLang) {
                    context.read<LanguageCubit>().toggleLanguage();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      if (mounted) {
        showSnackBar(
          AppLocalizations.of(context)!.error,
          context,
          isError: true,
        );
      }
      return null;
    }
  }

  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final loginFuture = FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text,
      );

      final delayFuture = Future.delayed(const Duration(seconds: 2));

      await Future.wait([loginFuture, delayFuture]);

      if (!mounted) return;
      showSnackBar(
        AppLocalizations.of(context)!.loginSuccess,
        context,
        isError: false,
      );

      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      DialogUtils.showMessage(
        backgroundColor: AppColors.grayColor,
        context: context,
        message: _getAuthErrorMessage(e.code, context),
        title: AppLocalizations.of(context)!.error,
        posActionName: AppLocalizations.of(context)!.ok,
        posAction: () {},
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      DialogUtils.showMessage(
        backgroundColor: AppColors.grayColor,
        context: context,
        message: AppLocalizations.of(context)!.error,
        title: AppLocalizations.of(context)!.error,
        posActionName: AppLocalizations.of(context)!.ok,
        posAction: () {},
      );
    }
  }

  String _getAuthErrorMessage(String errorCode, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (errorCode) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return localizations.invalidCredentials;
      case 'too-many-requests':
        return localizations.tooManyRequests;
      case 'network-request-failed':
        return localizations.networkError;
      default:
        return localizations.defaultAuthError;
    }
  }
}
