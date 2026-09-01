import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/cubit/cubit_language.dart';
import 'package:movie_app/utils/dialog_utilis.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/snakbar_widget.dart';
import '../login_screen/language_toggle_switch.dart';
import 'avatar_selector.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmedController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String selectedAvatar = AppAssets.imageAvatar1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;
    final double screenWidth = context.width;
    final localizations = AppLocalizations.of(context);
    final String currentLang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.yelloColor),
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.015,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AvatarSelector(
                  onAvatarSelected: (avatar) {
                    selectedAvatar = avatar;
                  },
                ),
                SizedBox(height: screenHeight * 0.025),

                CustomTextField(
                  controller: nameController,
                  textStyle: AppTextStyles.regular16White,
                  hintText: localizations?.name ?? '',
                  hintStyle: AppTextStyles.regular16White,
                  fillColor: AppColors.grayColor,
                  borderColor: AppColors.transparent,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconName),
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),

                CustomTextField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterEmail;
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(emailController.text.trim());
                    if (!emailValid) {
                      return localizations?.invalidCredentials ??
                          AppLocalizations.of(context)!.pleaseEnterValidEmail;
                    }
                    return null;
                  },
                  controller: emailController,
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

                CustomTextField(
                  controller: passController,
                  textStyle: AppTextStyles.regular16White,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterYourPass;
                    }
                    if (text.length < 6) {
                      return localizations?.weakPassword ??
                          AppLocalizations.of(context)!.passValidation;
                    }
                    return null;
                  },
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

                CustomTextField(
                  controller: confirmedController,
                  textStyle: AppTextStyles.regular16White,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseConfirm;
                    }
                    if (text != passController.text) {
                      return localizations?.passwordDontMatch ??
                          AppLocalizations.of(context)!.passValidation;
                    }
                    return null;
                  },
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

                CustomTextField(
                  controller: phoneController,
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
                              register();
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.blackColor,
                              strokeWidth: 3.5,
                            ),
                          )
                        : Text(
                            localizations?.createAccount ?? '',
                            style: AppTextStyles.bold20Black,
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

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

                LanguageToggleSwitch(
                  currentLanguage: currentLang,
                  onLanguageChanged: (newLang) {
                    context.read<LanguageCubit>().toggleLanguage();
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text,
          );

      await userCredential.user?.updateDisplayName(nameController.text.trim());
      await userCredential.user?.updatePhotoURL(selectedAvatar);

      final delayFuture = Future.delayed(const Duration(seconds: 2));
      await delayFuture;

      if (!mounted) return;
      showSnackBar(
        AppLocalizations.of(context)!.regSuccess,
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
        message: getRegisterErrorMessage(e.code, context),
        title: AppLocalizations.of(context)!.error,
        posActionName: AppLocalizations.of(context)!.ok,
        posAction: () {},
        negActionName: AppLocalizations.of(context)!.cancel,
        negAction: () {},
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      DialogUtils.showMessage(
        backgroundColor: AppColors.grayColor,
        context: context,
        message: AppLocalizations.of(context)!.defaultAuthError,
        title: AppLocalizations.of(context)!.error,
        posActionName: AppLocalizations.of(context)!.ok,
        posAction: () {},
      );
    }
  }

  String getRegisterErrorMessage(String errorCode, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (errorCode) {
      case 'email-already-in-use':
        return localizations.emailAlreadyInUse;
      case 'invalid-email':
        return localizations.invalidCredentials;
      case 'weak-password':
        return localizations.weakPassword;
      case 'network-request-failed':
        return localizations.networkError;
      default:
        return localizations.defaultAuthError;
    }
  }
}
