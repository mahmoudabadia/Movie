import 'package:flutter/material.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/available_movies_response.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../api/model/genre.dart';
import '../../../../utils/app_colors.dart';
import 'category_item_widget.dart';
import 'movies_grid_widget.dart';

class ProwseTab extends StatefulWidget {
  const ProwseTab({super.key});

  @override
  State<ProwseTab> createState() => _ProwseTabState();
}

class _ProwseTabState extends State<ProwseTab> {
  int selectedCategoryIndex = 0;
  final List<String> categories = AppGenres.list;

  late Future<AvailableMoviesResponse?> moviesFuture;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() {
    final selectedGenre = categories[selectedCategoryIndex];
    moviesFuture = ApiManager.getMovies(genre: selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * .02),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:  EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedCategoryIndex == index;
                  return CategoryItemWidget(
                    categoryName: categories[index],
                    isSelected: isSelected,
                    onTap: () {
                      if (selectedCategoryIndex == index) return;
                      setState(() {
                        selectedCategoryIndex = index;
                        fetchMovies();
                      });
                    },
                  );
                },
              ),
            ),

            SizedBox(height: height * .02),

            Expanded(child: MoviesGridWidget(moviesFuture: moviesFuture)),
          ],
        ),
      ),
    );
  }
}
