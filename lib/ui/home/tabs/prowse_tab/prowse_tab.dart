import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';

class ProwseTab extends StatelessWidget {
  const ProwseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(child: Image.asset(AppAssets.imageNoMovies)),
    );
  }
}
