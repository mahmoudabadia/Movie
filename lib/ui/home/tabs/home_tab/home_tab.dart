import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_text_styles.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(AppAssets.imageOnBoarding5, fit: BoxFit.cover),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.grayColor.withValues(alpha: 0.9),
                    AppColors.blackColor.withValues(alpha: 0.6),
                    AppColors.blackColor,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Image.asset(AppAssets.imageAvailableNow, fit: BoxFit.cover),
                  SizedBox(height: 350), //todo : show ,ovie on home tab
                  Image.asset(AppAssets.imageWatchNow, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        //todo: SeeMore
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.seeMore,
                            style: AppTextStyles.regular14Yellow,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.yelloColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //todo: action
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
