import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/service_provider/controller/review_controller.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/rating_summary.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/ratting_distribution_widget.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/review_filter_star_buttons.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/review_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpReviewsTabViewWidget extends StatelessWidget {
  const EpSpReviewsTabViewWidget({
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber, size: 22.5),

          /// Rating Summary Section
          EpSpRatingSummary(controller: controller),
          SizedBox(height: 16),

          /// Rating Distribution
          EpSpRattingDistributionWidget(
            controller: controller,
            isFemale: isFemale,
            femaleColorController: femaleColorController,
          ),
          SizedBox(height: 16),

          /// Leave a Review Text Field
          TextFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Review",
              hintText: "leave a review",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 16),

          /// Star buttons
          EpSpReviewFilterStarButtons(),
          SizedBox(height: 20),

          ///
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Review",
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ),
          // SizedBox(height: 16),
          // Reviews List
          EpSpReviewListWidget(),
        ],
      ),
    );
  }
}
