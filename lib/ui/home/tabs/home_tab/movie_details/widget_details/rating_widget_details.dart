import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/size_utils.dart';

class RatingWidgetDetails extends StatelessWidget {
  RatingWidgetDetails({
    super.key,
    required this.rating,
    required this.imageRating,
    required this.textStyle,
    this.bGColor,
    this.width,
    this.height,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final String rating;
  final String imageRating;
  final TextStyle textStyle;
  Color? bGColor;
  double? width;
  double? height;
  double? verticalPadding;
  double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: verticalPadding ?? 5,
        vertical: horizontalPadding ?? 6,
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bGColor ?? AppColors.grayColor,
      ),
      child: Row(
        spacing: context.width * 0.01,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageRating,
            width: context.width * 0.06,
            height: context.height * 0.04,
          ),
          Text(rating, style: textStyle),
        ],
      ),
    );
  }
}
