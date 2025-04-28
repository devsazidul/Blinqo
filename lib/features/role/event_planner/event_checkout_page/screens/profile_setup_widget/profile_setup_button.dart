import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSetupButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool isFemale;
  const ProfileSetupButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isFemale,
  });

  @override
  Widget build(BuildContext context) {
    final femaleColorController = Get.find<PickColorController>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color:
              isFemale
                  ? femaleColorController.selectedColor
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
