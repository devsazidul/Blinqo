import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/service_provider/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpRattingDistributionWidget extends StatelessWidget {
  const EpSpRattingDistributionWidget({
    super.key,
    required this.controller,
    required this.isFemale,
    required this.femaleColorController,
  });

  final EpSpReviewController controller;
  final bool isFemale;
  final PickColorController femaleColorController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(ProfileController()).isDarkMode.value;
    return Obx(
      () => Column(
        children: List.generate(5, (index) {
          int star = 5 - index;
          double percentage = controller.ratingDistribution[star] ?? 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text(
                  "$star",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : AppColors.textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.star, color: Colors.amber, size: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "${percentage.toStringAsFixed(0)}%",
                  style: getTextStyle(
                    fontSize: 14,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.textColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
