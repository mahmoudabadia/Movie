import 'package:flutter/material.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_styles.dart';

class MovieRatingBadge extends StatelessWidget {
  final double rating;

  const MovieRatingBadge({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toString(),
            style: AppTextStyles.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(
            Icons.star,
            color: AppColors.yelloColor,
            size: 12,
          ),
        ],
      ),
    );
  }
}