import 'package:flutter/material.dart';

import 'package:movie_app/api/dio_manager.dart';

import 'package:movie_app/api/movie.dart';

import 'package:movie_app/l10n/app_localizations.dart';

import 'package:movie_app/ui/home/tabs/home_tab/movie_details/widget_details/rating_widget_details.dart';

import 'package:movie_app/ui/home/tabs/profile_tab/history_firestore/history_firestore.dart';

import 'package:movie_app/ui/widgets/custom_elevated_button.dart';

import 'package:movie_app/utils/app_assets.dart';

import 'package:movie_app/utils/app_colors.dart';

import 'package:movie_app/utils/app_text_styles.dart';

import 'package:movie_app/utils/size_utils.dart';
import 'package:movie_app/utils/toast_utilis.dart';

class StackWidgetPictureMovie extends StatefulWidget {
  final Movie? movie;

  const StackWidgetPictureMovie({
    super.key,
    required this.coverImage,
    required this.title,
    required this.year,
    required this.likeCount,
    required this.runtime,
    required this.rating,
    this.movie,
  });

  final String coverImage;
  final String title;
  final int year;
  final int likeCount;
  final int runtime;
  final double rating;

  @override
  State<StackWidgetPictureMovie> createState() =>
      _StackWidgetPictureMovieState();
}

class _StackWidgetPictureMovieState extends State<StackWidgetPictureMovie> {
  Future<void> watchMovie() async {
    if (widget.movie == null) return;
    try {
      final isAlreadyInHistory = await HistoryFirestore.isMoveiInHistory(
        widget.movie!.id!,
      );

      if (isAlreadyInHistory) {
        ToastUtils.showCustomToast(
          context: context,
          message: "Movie is Already in History 😉",
          backgroundColor: AppColors.lightYelloColor,
          textColor: AppColors.blackColor,
        );
      } else {
        await HistoryFirestore.addToHistory(widget.movie!);
        ToastUtils.showCustomToast(
          context: context,
          message: "Movie added to History",
          backgroundColor: AppColors.yelloColor,
          textColor: AppColors.blackColor,
          icon: Icons.check_circle_rounded,
        );
      }

      DioManager.openMovieUrl(widget.movie?.url);
    } catch (e) {
      if (!context.mounted) return;

      ToastUtils.showCustomToast(
        context: context,
        message: "Something went wrong",
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        icon: Icons.error_rounded,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(widget.coverImage, fit: BoxFit.cover),
        Container(
          height: context.height * 0.8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.2),
                Colors.black,
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            spacing: context.height * 0.020,
            children: [
              SizedBox(height: context.height * 0.22),
              InkWell(
                onTap: () {
                  print('Movie URL: ${widget.movie?.url}');
                  print('YT Trailer: ${widget.movie?.ytTrailerCode}');
                  DioManager.openMovieUrl(widget.movie?.url);
                },
                child: Image.asset(AppAssets.imagePlaying),
              ),
              Spacer(),
              Text(
                widget.title,
                style: AppTextStyles.bold24White,
                textAlign: TextAlign.center,
              ),
              Text('${widget.year}', style: AppTextStyles.bold20Gray),
              CustomElevatedButton(
                horizontalPadding: context.width * 0.38,
                verticalPadding: context.height * 0.015,
                sideColor: AppColors.redColor,
                backgroundColor: AppColors.redColor,
                onPressed: () {
                  watchMovie();
                },
                child: Text(
                  AppLocalizations.of(context)!.watch,
                  style: AppTextStyles.bold20White,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RatingWidgetDetails(
                      rating: '${widget.likeCount}',
                      imageRating: AppAssets.iconLove,
                      textStyle: AppTextStyles.bold24White,
                    ),
                  ),
                  Expanded(
                    child: RatingWidgetDetails(
                      rating: '${widget.runtime}',
                      imageRating: AppAssets.iconTime,
                      textStyle: AppTextStyles.bold24White,
                    ),
                  ),
                  Expanded(
                    child: RatingWidgetDetails(
                      rating: '${widget.rating}',
                      imageRating: AppAssets.iconStar,
                      textStyle: AppTextStyles.bold24White,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
