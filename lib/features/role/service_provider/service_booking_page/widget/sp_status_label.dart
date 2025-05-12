import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class SpStatusLabel extends StatelessWidget {
  final Color color;
  final String label;

  SpStatusLabel({super.key, required this.color, required this.label});
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
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
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
        ],
      );
    });
  }
}
