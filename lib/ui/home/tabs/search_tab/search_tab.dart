import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/tabs/search_tab/search_widget.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../widgets/custom_text_field.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          SearchWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 10),
            child: CustomTextField(
              textStyle: AppTextStyles.regular16White,
              fill: true,
              hintText: AppLocalizations.of(context)!.search,
              hintStyle: AppTextStyles.regular16White,
              onChanged: (p0) {
                //todo: search logic
              },
              labelStyle: AppTextStyles.regular20White,
              redius: 22,

              borderColor: AppColors.grayColor,
              prefixIcon: Image.asset(AppAssets.iconSearch),
            ),
          ),
        ],
      ),
    );
  }
}
