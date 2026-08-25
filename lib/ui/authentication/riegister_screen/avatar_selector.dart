import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({super.key});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  int selectedIndex = 1;
  late final PageController _pageController;

  final List<String> avatars = [
    AppAssets.imageAvatar0,
    AppAssets.imageAvatar1,
    AppAssets.imageAvatar2,
    AppAssets.imageAvatar3,
    AppAssets.imageAvatar4,
    AppAssets.imageAvatar5,
    AppAssets.imageAvatar6,
    AppAssets.imageAvatar7,
    AppAssets.imageAvatar8,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: selectedIndex,
      viewportFraction: 0.35,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- Avatar PageView Slider ---
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _pageController,
            itemCount: avatars.length,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
              // TODO: Handle selected avatar change callback logic
            },
            itemBuilder: (context, index) {
              final bool isSelected = selectedIndex == index;

              return Center(
                child: GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.0 : 0.7,
                    duration: Duration(milliseconds: 250),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.transparent,
                      backgroundImage: AssetImage(avatars[index]),
                      onBackgroundImageError: (_, _) {},
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),

        // --- Avatar Label ---
        Text(
          localizations?.avatar ?? '',
          style: AppTextStyles.regular16White.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
