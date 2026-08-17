import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/tabs/home_tab/home_tap.dart';
import 'package:movie_app/ui/home/tabs/search_tap/search_tap.dart';
import 'package:movie_app/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:movie_app/utils/app_colors.dart';

import 'tabs/profile_tap/profile_tap.dart';
import 'tabs/prowse_tap/prowse_tap.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = [
      HomeTap(),
      SearchTap(),
      ProwseTap(),
      ProfileTap(),
    ];
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: pagesList[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
