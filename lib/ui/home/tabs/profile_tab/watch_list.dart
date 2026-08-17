import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(child: Image.asset(AppAssets.imageNoMovies)),
    );
  }
}
