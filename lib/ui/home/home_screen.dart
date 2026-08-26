import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:movie_app/ui/home/tabs/prowse_tab/prowse_tab.dart';
import 'package:movie_app/ui/home/tabs/search_tab/search_tab.dart';
import 'package:movie_app/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:movie_app/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = [
      HomeTab(),
      SearchTab(),
      ProwseTab(),
      ProfileTab(),
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
