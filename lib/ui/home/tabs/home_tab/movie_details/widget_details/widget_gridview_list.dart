import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

class WidgetGridviewList extends StatelessWidget {
  const WidgetGridviewList({
    super.key,
    required this.image,
    required this.rating,
  });

  final String image;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Image.network(image),
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(4),
            width: context.width * 0.15,
            height: context.height * 0.04,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: AppColors.grayColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(rating, style: AppTextStyles.regular16White),
                ),
                Expanded(child: Image.asset(AppAssets.iconStar2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
