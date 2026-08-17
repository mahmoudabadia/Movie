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
      color: AppColors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: AppColors.grayColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.yelloColor,
          unselectedItemColor: AppColors.whiteColor,
          currentIndex: widget.currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: widget.onTap,
          items: [
            buildNavigationBarItem(
              icon: AppAssets.iconHome,
              label: '',
              index: 0,
            ),
            buildNavigationBarItem(
              icon: AppAssets.iconSearch,
              label: '',
              index: 1,
            ),
            buildNavigationBarItem(
              icon: AppAssets.iconExplore,
              label: '',
              index: 2,
            ),
            buildNavigationBarItem(
              icon: AppAssets.iconProfile,
              label: '',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildNavigationBarItem({
    required String icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ColorFiltered(
        colorFilter: ColorFilter.mode(
          widget.currentIndex == index
              ? AppColors.yelloColor
              : AppColors.whiteColor,
          BlendMode.srcIn,
        ),
        child: Image.asset(icon),
      ),
      label: label,
    );
  }
}
