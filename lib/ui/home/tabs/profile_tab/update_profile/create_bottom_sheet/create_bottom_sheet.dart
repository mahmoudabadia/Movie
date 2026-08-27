import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({super.key});

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  int selectedAvatarIndex = -1;

  final List<String> avatars = const [
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GridView.builder(
      padding: EdgeInsets.only(
        top: height * 0.03,
        right: width * 0.06,
        left: width * 0.06,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 19,
        mainAxisSpacing: 27,
      ),
      itemBuilder: (context, index) {
        final isSelected = selectedAvatarIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedAvatarIndex = index;
            });

            Navigator.pop(context, index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.yelloColor : AppColors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.yelloColor, width: 2),
            ),
            child: Image.asset(avatars[index], fit: BoxFit.cover),
          ),
        );
      },
      itemCount: 9,
    );
  }
}
