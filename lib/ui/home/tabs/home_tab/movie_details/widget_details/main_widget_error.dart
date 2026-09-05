import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../../../utils/app_text_styles.dart';

class MainWidgetError extends StatelessWidget {
  MainWidgetError({super.key, required this.onPressed, required this.message});

  VoidCallback onPressed;
  String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: context.height * 0.02,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 100, color: AppColors.yelloColor),
          Text(
            message,
            style: AppTextStyles.bold24White,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              AppLocalizations.of(context)!.tryAgain,
              style: AppTextStyles.bold20Black,
            ),
          ),
        ],
      ),
    );
  }
}
