import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

import '../../utils/app_text_styles.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          AppLocalizations.of(context)!.homeScreen,
          style: AppTextStyles.bold20Black,
        ),
      ),
      body: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.welcome,
            style: AppTextStyles.bold20Black,
          ),
          Image.asset(AppAssets.imageForgetPass),
        ],
      ),
    );
  }
}
