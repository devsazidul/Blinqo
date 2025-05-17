import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class EpStatusLabel extends StatelessWidget {
  final Color color;
  final String label;

  EpStatusLabel({super.key, required this.color, required this.label});
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = profileController.isDarkMode.value;
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: isDarkMode ? AppColors.primary : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
