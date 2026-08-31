import 'dart:ui';

abstract final class AppColors {
  static const Color yelloColor = Color(0xFFF6BD00);
  static const Color blackColor = Color(0xFF121312);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color grayColor = Color(0xFF282A28);
  static const Color redColor = Color(0xFFE82626);
  static const Color transparent = Color(0x00000000);
  static const Color blue = Color(0xFF2196F3);
  static const Color greeen = Color(0xFF00FF00);




  /// color for selected avatar =>
  static final Color lightYelloColor = AppColors.yelloColor.withValues(alpha: 0.56);
}
