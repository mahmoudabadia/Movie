import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import '../../../../../api/model/available_movies_response.dart';
import '../../../../../utils/app_colors.dart';
import 'movie_rating_badge.dart';

class CarouselSection extends StatelessWidget {
  final Future<AvailableMoviesResponse?> future;
  final ValueChanged<String> onPageChanged;

  const CarouselSection({
    super.key,
    required this.future,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AvailableMoviesResponse?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 350,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.yelloColor),
            ),
          );
        } else if (snapshot.hasError || snapshot.data?.data?.movies == null) {
          return const SizedBox(
            height: 350,
            child: Center(
              child: Text(
                "Error loading movies",
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
          );
        }

        var moviesList = snapshot.data!.data!.movies!;

        return CarouselSlider.builder(
          itemCount: moviesList.length,
          options: CarouselOptions(
            height: 350,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            viewportFraction: 0.55,
            onPageChanged: (index, reason) {
              onPageChanged(moviesList[index].largeCoverImage ?? '');
            },
          ),
          itemBuilder: (context, index, realIndex) {
            var movie = moviesList[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    movie.mediumCoverImage ?? '',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.movie, color: AppColors.whiteColor, size: 50),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: MovieRatingBadge(rating: movie.rating ?? 0.0),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}