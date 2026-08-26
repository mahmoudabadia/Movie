import 'package:flutter/material.dart';
import '../../../../api/api_manager.dart';
import '../../../../api/model/available_movies_response.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import 'home_tab_widget/movie_rating_badge.dart';

class CategoryMoviesScreen extends StatefulWidget {
  final String genreName;

  const CategoryMoviesScreen({
    super.key,
    required this.genreName,
  });

  @override
  State<CategoryMoviesScreen> createState() => _CategoryMoviesScreenState();
}

class _CategoryMoviesScreenState extends State<CategoryMoviesScreen> {
  late Future<AvailableMoviesResponse?> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiManager.getMovies(
      genre: widget.genreName.toLowerCase(),
      limit: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.yelloColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.genreName,
          style: AppTextStyles.bold20White,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<AvailableMoviesResponse?>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yelloColor),
            );
          } else if (snapshot.hasError || snapshot.data?.data?.movies == null) {
            return const Center(
              child: Text("No movies found", style: TextStyle(color: Colors.white)),
            );
          }

          var movies = snapshot.data!.data!.movies!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.mediumCoverImage ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: MovieRatingBadge(rating: movie.rating ?? 0.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}