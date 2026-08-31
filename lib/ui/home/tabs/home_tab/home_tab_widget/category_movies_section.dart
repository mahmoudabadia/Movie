import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/tabs/home_tab/movie_details/movie_details_widget.dart';

import '../../../../../api/model/available_movies_response.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_styles.dart';
import '../category_movies_screen.dart';
import 'movie_rating_badge.dart';

class CategoryMoviesSection extends StatelessWidget {
  final String genreName;
  final Future<AvailableMoviesResponse?> future;

  const CategoryMoviesSection({
    super.key,
    required this.genreName,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(genreName, style: AppTextStyles.bold20White),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryMoviesScreen(genreName: genreName),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.seeMore,
                      style: AppTextStyles.regular14Yellow,
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.yelloColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder<AvailableMoviesResponse?>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 180,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.yelloColor),
                ),
              );
            } else if (snapshot.hasError ||
                snapshot.data?.data?.movies == null) {
              return const SizedBox(height: 180);
            }

            var categoryMovies = snapshot.data!.data!.movies!;

            return SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: categoryMovies.length,
                itemBuilder: (context, index) {
                  var movie = categoryMovies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsWidget(id: movie.id!),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movie.mediumCoverImage ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 6,
                                left: 6,
                                child: MovieRatingBadge(
                                  rating: movie.rating ?? 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
