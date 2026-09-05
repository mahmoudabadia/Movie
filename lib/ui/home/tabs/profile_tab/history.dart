import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/tabs/home_tab/home_tab_widget/movie_rating_badge.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/history_delete_button/history_delete_button.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/history_firestore/history_firestore.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';
import 'package:movie_app/utils/toast_utilis.dart';
import '../../../../utils/app_colors.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: HistoryFirestore.historyStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yelloColor),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "something went wrong",
                style: AppTextStyles.regular16White,
              ),
            );
          }
          final movies = snapshot.data?.docs ?? [];
          if (movies.isEmpty) {
            return Center(child: Image.asset(AppAssets.imageNoMovies));
          }
          return GridView.builder(
            padding: EdgeInsets.only(
              top: context.height * 0.02,
              left: context.width * 0.04,
              right: context.width * 0.04,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.58,
              crossAxisSpacing: context.width * 0.03,
              mainAxisSpacing: context.height * 0.015,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index].data();
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 122 / 175,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.network(
                            movie["poster"] ?? "",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: context.height * 0.02,
                            left: context.width * 0.02,
                            child: MovieRatingBadge(
                              rating: (movie["rating"] ?? 0).toDouble(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  HistoryDeleteButton(
                    onPressed: () async {
                      try {
                        await HistoryFirestore.deleteFromHstory(
                          int.parse(movie["id"].toString()),
                        );
                        if (!context.mounted) return;
                        ToastUtils.showCustomToast(
                          context: context,
                          message: "Movie Delete Successfully",
                          backgroundColor: AppColors.greeen,
                          textColor: AppColors.whiteColor,
                          icon: Icons.check_circle_rounded,
                        );
                      } catch (e) {
                        if (!context.mounted) return;
                        ToastUtils.showCustomToast(
                          context: context,
                          message: "Delete failed. Please try again.",
                          backgroundColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                          icon: Icons.error_rounded,
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
