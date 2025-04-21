import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileSetupButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final ThemeMode themeMode;
  const ProfileSetupButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color:
              themeMode == ThemeMode.dark
                  ? AppColors.buttonColor2
                  : AppColors.buttonColor2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: getTextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
