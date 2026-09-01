import 'package:flutter/material.dart';
import 'package:movie_app/api/model/available_movies_response.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../home_tab/home_tab_widget/movie_rating_badge.dart';
import '../home_tab/movie_details/movie_details_widget.dart';

class MoviesGridWidget extends StatelessWidget {
  final Future<AvailableMoviesResponse?> moviesFuture;

  const MoviesGridWidget({
    super.key,
    required this.moviesFuture,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AvailableMoviesResponse?>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yelloColor,
            ),
          );
        } else if (snapshot.hasError || snapshot.data?.data?.movies == null) {
          return Center(
            child: Text(
             AppLocalizations.of(context)!.noMovies,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
          );
        }

        final movies = snapshot.data!.data!.movies!;

        if (movies.isEmpty) {
          return  Center(
            child: Text(
              AppLocalizations.of(context)!.noMovies,
              style: TextStyle(color: AppColors.whiteColor),
            ),
          );
        }

        return GridView.builder(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsWidget(id: movie.id),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
                      fit: BoxFit.cover,
                    ),
                    if (movie.rating != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: MovieRatingBadge(
                          rating: movie.rating?.toDouble() ?? 0.0,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}