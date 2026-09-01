import 'package:flutter/material.dart';
import 'package:movie_app/api/movie.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_text_styles.dart';

class ScreenShotSection extends StatelessWidget {
  const ScreenShotSection({super.key, required this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.screenShot,
          style: AppTextStyles.bold24White,
        ),
        ScreenShotWidget(image: movie?.largeScreenshotImage1 ?? ''),
        ScreenShotWidget(image: movie?.largeScreenshotImage2 ?? ''),
        ScreenShotWidget(image: movie?.largeScreenshotImage3 ?? ''),
      ],
    );
  }
}

class ScreenShotWidget extends StatelessWidget {
  const ScreenShotWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(image),
    );
  }
}
