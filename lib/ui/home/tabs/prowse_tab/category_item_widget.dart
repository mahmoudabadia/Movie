import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/size_utils.dart';

class CategoryItemWidget extends StatelessWidget {

  final String categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItemWidget({
    super.key,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;


    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.only(right: 12),
        padding:  EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.yelloColor : AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.yelloColor,
            width: width*.002,
          ),
        ),
        child:  Text(
          categoryName,
          style: isSelected
              ? AppTextStyles.bold14Black
              : AppTextStyles.bold14Yellow,
        ),
      ),
    );
  }
}