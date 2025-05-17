import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/service_provider/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpRatingSummary extends StatelessWidget {
  const EpSpRatingSummary({super.key, required this.controller});

  final EpSpReviewController controller;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(ProfileController()).isDarkMode.value;
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${controller.averageRating}",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
            ),
          ),
          SizedBox(width: 4),
          Text(
            "(${controller.reviewCount})",
            style: getTextStyle(
              fontSize: 14,
              color: Color(0xffA1A1A1),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
