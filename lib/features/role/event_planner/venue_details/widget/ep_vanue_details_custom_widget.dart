import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpVenueDeatilsCustomWidget extends StatelessWidget {
  final String imagePath;
  final String guestText;

  EpVenueDeatilsCustomWidget({
    super.key,
    required this.imagePath,
    required this.guestText,
  });
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = controller.isDarkMode.value;
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 20,
          height: 20,
          fit: BoxFit.cover,
          color: isDarkMode ? AppColors.buttonColor : AppColors.textColor,
        ),
        SizedBox(width: 5),
        Text(
          guestText,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? AppColors.primary : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
