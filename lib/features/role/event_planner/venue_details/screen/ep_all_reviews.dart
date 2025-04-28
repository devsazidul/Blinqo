import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/controller/ep_venuw_details_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/widget/ep_venue_details_custom_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpAllReviews extends StatelessWidget {
  EpAllReviews({super.key});
  final EpVenuwDetailsController epVenuwDetailsController = Get.put(
    EpVenuwDetailsController(),
  );
  final ProfileController themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  isDarkMode
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.textColor.withValues(alpha: 0.15),
              child: Image.asset(
                IconPath.arrowleft,
                width: 16,
                height: 12,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Project Request ",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: epVenuwDetailsController.reviews.length,
            itemBuilder: (context, index) {
              final review = epVenuwDetailsController.reviews[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EpVenueDetailsCustomReviewsWidget(
                    userName: review["userName"]!,
                    userIcon: review["userIcon"]!,
                    reviewDate: review["reviewDate"]!,
                    reviewText: review["reviewText"]!,
                    rating: int.parse(review["rating"]!),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
