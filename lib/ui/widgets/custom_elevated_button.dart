import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';


class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double? redius;
  final Color? sideColor;
  final double? verticalPadding;
  final double? horizontalPadding;




  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.redius,
    this.verticalPadding,
    this.sideColor,
    this.horizontalPadding,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.whiteColor,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(redius ?? 16),
          side: BorderSide(
            color: sideColor ?? AppColors.whiteColor,
            width: 2,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
