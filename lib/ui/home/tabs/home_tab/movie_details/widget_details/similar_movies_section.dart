import 'package:flutter/material.dart';
import 'package:movie_app/api/movie.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/ui/home/tabs/home_tab/movie_details/movie_details_widget.dart';
import 'package:movie_app/ui/home/tabs/home_tab/movie_details/widget_details/widget_gridview_list.dart';
import 'package:movie_app/utils/app_text_styles.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.similar,
          style: AppTextStyles.bold24White,
        ),

        const SizedBox(height: 12),

        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 189 / 279,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsWidget(id: movie.id!),
                  ),
                );
              },
              child: WidgetGridviewList(
                image: movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
                rating: '${movie.rating ?? 0}',
              ),
            );
          },
        ),
      ],
    );
  }
}
