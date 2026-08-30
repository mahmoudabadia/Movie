import 'package:flutter/material.dart';
import 'package:movie_app/api/movie.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key, required this.movie});

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.height * 0.01,
      children: [
        Text(
          AppLocalizations.of(context)!.summary,
          style: AppTextStyles.bold24White,
        ),
        Text(movie?.descriptionFull ?? '', style: AppTextStyles.regular16White),
      ],
    );
  }
}
