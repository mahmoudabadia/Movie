import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

void showSnackBar(String message, BuildContext context, {bool isError = false}) {
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 4,
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? AppColors.redColor : AppColors.yelloColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle,
            color: isError ? AppColors.whiteColor : AppColors.blackColor,
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: isError
                  ? AppTextStyles.regular16White
                  : AppTextStyles.regular20Black,
            ),
          ),
        ],
      ),
    ),
  );
}