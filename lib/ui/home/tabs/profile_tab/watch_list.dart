import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';

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

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movieData = movies[index].data() as Map<String, dynamic>;
              final String? posterPath = movieData['posterPath'];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: posterPath != null && posterPath.isNotEmpty
                        ? Image.network(
                      posterPath,
                      width: 60,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.movie, size: 40, color: AppColors.whiteColor),
                    )
                        : const Icon(Icons.movie, size: 40, color: AppColors.whiteColor),
                  ),
                  title: Text(
                    movieData['title'] ?? 'No Title',
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    movieData['releaseDate'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
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