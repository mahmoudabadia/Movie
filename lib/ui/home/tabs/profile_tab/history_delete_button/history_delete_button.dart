import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

class HistoryDeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const HistoryDeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: context.height * 0.03,

        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: AppColors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Delete", style: AppTextStyles.regular14Withe),

            const SizedBox(width: 10),

            Text("🗑️", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
