import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/size_utils.dart';
import '../riegister_screen/rigester_screen.dart';

class CreateAccountRow extends StatelessWidget {
  const CreateAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = context.width;
    final localizations = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localizations?.dontHaveAccount ?? '',
          style: AppTextStyles.regular16White.copyWith(
            fontSize: screenWidth * 0.033,
            color: AppColors.whiteColor.withValues(alpha: 0.8),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
              ),
            );
          },
          child: Text(
            localizations?.createOne ?? '',
            style: AppTextStyles.bold14Yellow.copyWith(
              fontSize: screenWidth * 0.033,
            ),
          ),
        ),
      ],
    );
  }
}