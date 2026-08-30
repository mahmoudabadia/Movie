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
            padding: EdgeInsets.only(top: 10 , bottom: 10, left: 10, ),
            width: context.width * 0.15,
            height: context.height * 0.04,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(rating, style: AppTextStyles.regular14Withe),
                ),
                Expanded(child: Image.asset(AppAssets.iconStar)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
