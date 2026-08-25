import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/update_profile/create_bottom_sheet/create_bottom_sheet.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/update_profile/create_delete/delete_dialog.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/ui/widgets/custom_text_field.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_text_styles.dart';

import '../../../../../utils/toast_utilis.dart';

class CreateUpdate extends StatefulWidget {
  const CreateUpdate({super.key});

  @override
  State<CreateUpdate> createState() => _CreateUpdateState();
}

class _CreateUpdateState extends State<CreateUpdate> {
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

  int selectedAvatarIndex = 0;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    nameController = TextEditingController(text: user?.displayName ?? "");
    phoneController = TextEditingController(text: "0120000");

    if (user?.photoURL != null) {
      final index = avatars.indexOf(user!.photoURL!);
      if (index != -1) {
        selectedAvatarIndex = index;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.yelloColor,
            size: 35,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.pick,
          style: AppTextStyles.regular16Yellow,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            avatars[selectedAvatarIndex],
            width: width * 0.40,
            height: height * 0.22,
            fit: BoxFit.contain,
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.02,
            ),
            child: SizedBox(
              height: height * (55.72 / 932),
              width: width * (398 / 430),
              child: CustomTextField(
                borderColor: AppColors.grayColor,
                textStyle: AppTextStyles.regular16White,
                prefixIcon: const Icon(Icons.person, color: AppColors.whiteColor),
                controller: nameController,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: SizedBox(
              height: height * (55.72 / 932),
              width: width * (398 / 430),
              child: CustomTextField(
                borderColor: AppColors.grayColor,
                textStyle: AppTextStyles.regular16White,
                prefixIcon: const Icon(
                  Icons.phone_rounded,
                  color: AppColors.whiteColor,
                ),
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
            ),
          ),

          SizedBox(height: height * 0.02),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text(
                AppLocalizations.of(context)!.reset,
                style: AppTextStyles.regular20White,
              ),
            ),
          ),

          const Spacer(),

          SizedBox(
            height: height * (55.72 / 932),
            width: width * (398 / 430),
            child: CustomElevatedButton(
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => const DeleteDialog(),
                );

                if (result == true) {
                }
              },
              backgroundColor: AppColors.redColor,
              sideColor: AppColors.redColor,
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: AppTextStyles.regular20White,
              ),
            ),
          ),

          SizedBox(height: height * 0.02),

          SizedBox(
            height: height * (55.72 / 932),
            width: width * (398 / 430),
            child: CustomElevatedButton(
              onPressed: isLoading
                  ? () {}
                  : () async {
                final selectedIndex = await showModalBottomSheet<int>(
                  backgroundColor: AppColors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      height: height * 0.45,
                      margin: EdgeInsets.only(
                        bottom: height * 0.01,
                        left: width * 0.02,
                        right: width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grayColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const CreateBottomSheet(),
                    );
                  },
                );

                if (selectedIndex != null) {
                  setState(() {
                    selectedAvatarIndex = selectedIndex;
                  });
                }

                setState(() {
                  isLoading = true;
                });

                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await user.updateDisplayName(nameController.text.trim());
                  await user.updatePhotoURL(avatars[selectedAvatarIndex]);
                  await user.reload();
                }

                if (!context.mounted) return;
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);
                ToastUtils.showCustomToast(
                  context: context,
                  message: AppLocalizations.of(context)!.updatedSucsess,
                  backgroundColor: AppColors.yelloColor,
                  textColor: AppColors.blackColor,
                  icon: Icons.check_circle,
                  iconColor: AppColors.blackColor,
                );
              },
              backgroundColor: AppColors.yelloColor,
              sideColor: AppColors.yelloColor,
              child: isLoading
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppColors.blackColor,
                  strokeWidth: 3,
                ),
              )
                  : Text(
                AppLocalizations.of(context)!.update,
                style: AppTextStyles.regular20Black,
              ),
            ),
          ),

          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }
}