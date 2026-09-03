import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.characterName,
  });

  final String imageUrl;
  final String name;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.1,
      margin: EdgeInsets.symmetric(
        horizontal: context.width * 0.03,
        vertical: context.height * 0.01,
      ),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.grayColor,
      ),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColors.yelloColor),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Expanded(
                  child: Text(
                    'Name : $name ',
                    style: AppTextStyles.regular14Withe,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Character : $characterName',
                    style: AppTextStyles.regular14Withe,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
