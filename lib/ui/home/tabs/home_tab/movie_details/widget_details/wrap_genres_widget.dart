import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';

class WrapGenresWidget extends StatelessWidget {
  const WrapGenresWidget({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grayColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(genre, style: AppTextStyles.regular14Withe),
    );
  }
}
