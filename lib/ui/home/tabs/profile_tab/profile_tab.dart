import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/watch_list.dart';
import 'package:movie_app/utils/app_routes.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/size_utils.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'history.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var _ = context.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                color: AppColors.grayColor,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  left: 12,
                  right: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Image.asset(AppAssets.imageAvatar0, height: 90),
                              SizedBox(height: context.height * 0.01),
                              Text(
                                "Route",
                                style: AppTextStyles.bold20White,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Text("0", style: AppTextStyles.bold36White),
                              SizedBox(height: context.height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.watchList,
                                style: AppTextStyles.bold20White,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text("0", style: AppTextStyles.bold36White),
                              SizedBox(height: context.height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.history,
                                style: AppTextStyles.bold20White,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.createUpdateRouteName,
                              );
                            },
                            backgroundColor: AppColors.yelloColor,
                            sideColor: AppColors.yelloColor,
                            verticalPadding: 10,
                            horizontalPadding: 0,
                            redius: 16,
                            child: Text(
                              AppLocalizations.of(context)!.editProfile,
                              style: AppTextStyles.regular20Black,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: context.width * 0.03),
                        Expanded(
                          flex: 4,
                          child: CustomElevatedButton(
                            onPressed: () {
                              //todo: logout logic
                            },
                            backgroundColor: AppColors.redColor,
                            sideColor: AppColors.redColor,
                            verticalPadding: 10,
                            horizontalPadding: 0,
                            redius: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.exit,
                                  style: AppTextStyles.regular20White,
                                ),
                                SizedBox(width: context.width * 0.02),
                                Icon(
                                  Icons.logout_outlined,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    TabBar(
                      labelColor: AppColors.yelloColor,
                      unselectedLabelColor: AppColors.whiteColor,
                      dividerColor: Colors.transparent,
                      labelPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3.5,
                          color: AppColors.yelloColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                      tabs: [
                        Tab(
                          iconMargin: EdgeInsets.symmetric(vertical: 16),
                          text: AppLocalizations.of(context)!.watchList,
                          icon: Image.asset(
                            AppAssets.iconWatchList,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.symmetric(vertical: 6),
                          text: AppLocalizations.of(context)!.history,
                          icon: Image.asset(
                            AppAssets.iconHistory,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 6,
              child: TabBarView(children: [WatchList(), History()]),
            ),
          ],
        ),
      ),
    );
  }
}
