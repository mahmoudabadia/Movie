import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/api/cubit_dio/details_state.dart';
import 'package:movie_app/api/cubit_dio/view_model_details.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/ui/home/tabs/home_tab/movie_details/widget_details/stack_widget_picture_movie.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

import 'widget_details/cast_section.dart';
import 'widget_details/main_widget_error.dart';
import 'widget_details/screen_shot_section.dart';
import 'widget_details/similar_movies_section.dart';
import 'widget_details/summary_section.dart';
import 'widget_details/wrap_genres_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  MovieDetailsWidget({super.key, this.id});

  int? id;

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  late ViewModelDetails viewModelDetails;

  @override
  void initState() {
    super.initState();
    viewModelDetails = ViewModelDetails();
    viewModelDetails.getDetailsFilmId(widget.id ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewModelDetails, DetailsState>(
      bloc: viewModelDetails,
      builder: (context, state) {
        if (state is DetailsLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.yelloColor),
          );
        }
        if (state is DetailsError) {
          return MainWidgetError(
            message: state.message,
            onPressed: () {
              viewModelDetails.getDetailsFilmId(widget.id ?? 1);
            },
          );
        }
        if (state is DetailsSuccess) {
          final movie = state.details!.data!.movie;
          final similarMovies = viewModelDetails.similarMovies;
          final genresList = movie?.genres ?? [];
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              foregroundColor: AppColors.whiteColor,
              backgroundColor: AppColors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AppAssets.iconArrowBack,

                  color: AppColors.whiteColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                    size: 44,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.blackColor,
            body: SingleChildScrollView(
              child: Column(
                spacing: context.height * 0.02,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StackWidgetPictureMovie(
                    movie: movie,
                    coverImage: movie?.largeCoverImage ?? '',
                    title: movie?.title ?? '',
                    year: movie?.year ?? 0,
                    likeCount: movie?.likeCount ?? 0,
                    runtime: movie?.runtime ?? 0,
                    rating: movie?.rating ?? 0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.width * 0.02),
                    child: Column(
                      spacing: context.height * 0.01,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenShotSection(movie: movie),
                        SimilarMoviesSection(movies: similarMovies),
                        SummarySection(movie: movie),
                        CastSection(cast: movie?.cast),
                        Text(
                          AppLocalizations.of(context)!.genres,
                          style: AppTextStyles.bold24White,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: genresList.map((genre) {
                            return WrapGenresWidget(genre: genre);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
