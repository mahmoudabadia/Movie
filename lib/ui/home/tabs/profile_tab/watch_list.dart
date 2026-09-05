import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../home_tab/movie_details/movie_details_widget.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Center(child: Image.asset(AppAssets.imageNoMovies)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('watchlist')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yelloColor),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Image.asset(AppAssets.imageNoMovies));
          }

          final movies = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movieData = movies[index].data() as Map<String, dynamic>;
              final String? posterPath = movieData['posterPath'];
              final dynamic ratingValue =
                  movieData['rating'] ?? movieData['voteAverage'] ?? 0.0;
              final String rating = ratingValue.toString();

              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsWidget(
                              id: movieData['id'] ?? int.parse(movies[index].id),
                            ),
                          ),
                        );
                      },

                      child: Positioned.fill(
                        child: posterPath != null && posterPath.isNotEmpty
                            ? Image.network(
                                posterPath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[900],
                                      child: const Icon(
                                        Icons.movie,
                                        size: 50,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                              )
                            : Container(
                                color: Colors.grey[900],
                                child: const Icon(
                                  Icons.movie,
                                  size: 50,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              rating,
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              color: AppColors.yelloColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
