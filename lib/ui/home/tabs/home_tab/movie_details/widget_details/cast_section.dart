import 'package:flutter/material.dart';
import 'package:movie_app/api/cast.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_text_styles.dart';

import 'cast_widget.dart';

class CastSection extends StatelessWidget {
  const CastSection({super.key, required this.cast});

  final List<Cast>? cast;

  @override
  Widget build(BuildContext context) {
    final castList = cast ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.cast,
          style: AppTextStyles.bold24White,
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: castList.length,
          itemBuilder: (context, index) {
            final actor = castList[index];

            return CastWidget(
              imageUrl: actor.urlSmallImage ?? '',
              name: actor.name ?? '',
              characterName: actor.characterName ?? '',
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 0);
          },
        ),
      ],
    );
  }
}
