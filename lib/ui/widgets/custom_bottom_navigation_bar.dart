import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: AppColors.grayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavigationBarItem(icon: AppAssets.iconHome, index: 0),
          buildNavigationBarItem(icon: AppAssets.iconSearch, index: 1),
          buildNavigationBarItem(icon: AppAssets.iconExplore, index: 2),
          buildNavigationBarItem(icon: AppAssets.iconProfile, index: 3),
        ],
      ),
    );
  }

  Widget buildNavigationBarItem({required String icon, required int index}) {
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          widget.currentIndex == index
              ? AppColors.yelloColor
              : AppColors.whiteColor,
          BlendMode.srcIn,
        ),
        child: Image.asset(icon, fit: BoxFit.contain),
      ),
    );
  }
}
