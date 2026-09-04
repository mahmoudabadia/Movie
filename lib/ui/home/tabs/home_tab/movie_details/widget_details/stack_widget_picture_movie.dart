import 'package:flutter/material.dart';
import 'package:movie_app/api/dio_manager.dart';
import 'package:movie_app/api/movie.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/ui/home/tabs/home_tab/movie_details/widget_details/rating_widget_details.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

class StackWidgetPictureMovie extends StatefulWidget {
  final Movie? movie;
  final String coverImage;
  final String title;
  final int year;
  final int likeCount;
  final int runtime;
  final double rating;

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

  @override
  State<StackWidgetPictureMovie> createState() =>
      _StackWidgetPictureMovieState();
}

class _StackWidgetPictureMovieState extends State<StackWidgetPictureMovie> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        SizedBox(
          width: double.infinity,
          height: context.height * 0.8,
          child: Image.network(widget.coverImage, fit: BoxFit.cover),
        ),


        Container(
          height: context.height * 0.8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.2),
                Colors.black,
              ],
            ),
          ),
        ),


        Positioned.fill(
          child: Column(
            children: [
              SizedBox(height: context.height * 0.22),
              InkWell(
                onTap: () {
                  DioManager.openMovieUrl(widget.movie?.url);
                },
                child: Image.asset(AppAssets.imagePlaying),
              ),
              const Spacer(),
              Text(
                widget.title,
                style: AppTextStyles.bold24White,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.height * 0.01),
              Text('${widget.year}', style: AppTextStyles.bold20Gray),
              SizedBox(height: context.height * 0.015),
              CustomElevatedButton(
                horizontalPadding: context.width * 0.38,
                verticalPadding: context.height * 0.015,
                sideColor: AppColors.redColor,
                backgroundColor: AppColors.redColor,
                onPressed: () {
                  DioManager.openMovieUrl(widget.movie?.url);
                },
                child: Text(
                  AppLocalizations.of(context)!.watch,
                  style: AppTextStyles.bold20White,
                ),
              ),
              SizedBox(height: context.height * 0.015),
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