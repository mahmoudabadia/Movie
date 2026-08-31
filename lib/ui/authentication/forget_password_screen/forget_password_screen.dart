import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/snakbar_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController _emailController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      if (!mounted) return;
      showSnackBar(
        AppLocalizations.of(context)!.plsEnterName,
        isError: true,
        context,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar(AppLocalizations.of(context)!.pass_send, context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(
          e.message ?? AppLocalizations.of(context)!.error_occur, isError: true,
          context);
      if (!mounted) return;

      showSnackBar(AppLocalizations.of(context)!.passSend, context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      showSnackBar(
        e.message ?? AppLocalizations.of(context)!.errorOccur,
        isError: true,
        context,
      );
    } catch (e) {
      if (!mounted) return;

      showSnackBar(
        AppLocalizations.of(context)!.unexpectedError,
        isError: true,
        context,
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;
    final double screenWidth = context.width;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.blackColor,
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
              CustomTextField(
                textStyle: AppTextStyles.regular20White,
                controller: _emailController,
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
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  backgroundColor: AppColors.yelloColor,
                  sideColor: AppColors.transparent,
                  redius: 15,
                  verticalPadding: 14,
                  onPressed: isLoading ? null : _handleResetPassword,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.blackColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
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
