import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../api/api_manager.dart';
import '../../../../api/model/available_movies_response.dart';
import '../../../../api/model/genre.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import 'home_tab_widget/carousel_section.dart';
import 'home_tab_widget/category_movies_section.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedBgImage = '';
  late String selectedGenre;

  late Future<AvailableMoviesResponse?> availableMoviesFuture;

  @override
  void initState() {
    super.initState();

    selectedGenre = AppGenres.list[Random().nextInt(AppGenres.list.length)];
    availableMoviesFuture = ApiManager.getMovies(limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          SizedBox.expand(
            child: selectedBgImage.isNotEmpty
                ? Image.network(selectedBgImage, fit: BoxFit.cover)
                : Image.asset(AppAssets.imageOnBoarding5, fit: BoxFit.cover),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.grayColor.withValues(alpha: 0.9),
                    AppColors.blackColor.withValues(alpha: 0.6),
                    AppColors.blackColor,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppAssets.imageAvailableNow,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),

                  CarouselSection(
                    future: availableMoviesFuture,
                    onPageChanged: (newBg) {
                      setState(() {
                        selectedBgImage = newBg;
                      });
                    },
                  ),

                  const SizedBox(height: 15),
                  Center(
                    child: Image.asset(
                      AppAssets.imageWatchNow,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppGenres.list.length,
                    itemBuilder: (context, index) {
                      var genre = AppGenres.list[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CategoryMoviesSection(
                          genreName: genre,
                          future: ApiManager.getMovies(
                            genre: genre.toLowerCase(),
                            limit: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}