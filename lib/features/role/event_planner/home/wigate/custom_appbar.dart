import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.screenWidth,
    required this.title, // Marked as required
    this.onTap,
    required this.themeMode,
  });

  final double screenWidth;
  final String title;
  final VoidCallback? onTap;
  final ThemeMode themeMode;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor:
          themeMode == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.buttonBuckdownColor2,
      forceMaterialTransparency: false,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: onTap ?? () => Get.back(),
          child: CircleAvatar(
            backgroundColor:
                themeMode == ThemeMode.dark
                    ? AppColors.darkBackgroundColor
                    : const Color(0xFFD9D9D9),
            child: Image.asset(
              IconPath.arrowLeftAlt,
              width: 16,
              height: 12,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: getTextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w600,
          color:
              themeMode == ThemeMode.dark
                  ? AppColors.borderColor2
                  : AppColors.buttonColor2,
        ),
      ),
    );
  }
}
