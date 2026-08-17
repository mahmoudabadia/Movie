import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/size_utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = context.width;
    final double logoSize = screenWidth * 0.47;

    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        AppAssets.imageSplashScreen,
        fit: BoxFit.contain,
      ),
    );
  }
}