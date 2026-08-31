import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle inter({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// ======  Size   36   ========
  static final TextStyle medium36White = inter(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );
  static final TextStyle bold36White = inter(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  /// ======  Size   24   ========
  static final TextStyle bold24White = inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  /// ======  Size   20   ========
  static final TextStyle regular20Gray = inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grayColor,
  );
  static final TextStyle regular20White = inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );
  static final TextStyle regular20Black = inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  );

  static final TextStyle semiBold20Black = inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static final TextStyle semiBold20Yellow = inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.yelloColor,
  );

  static final TextStyle bold20Gray = inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.grayColor,
  );
  static final TextStyle bold20White = inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static final TextStyle bold20Yellow = inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.yelloColor,
  );
  static final TextStyle bold20Black = inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  /// ======  Size   16   ========
  static final TextStyle regular16White = inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );
  static final TextStyle regular16Yellow = inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.yelloColor,
  );

  /// ======  Size   14   ========
  static final TextStyle regular14Yellow = inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.yelloColor,
  );
  static final TextStyle regular14Withe = inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );
  static final TextStyle bold14Yellow = inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.yelloColor,
  );
}
