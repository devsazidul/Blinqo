import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/screen/ep_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentlyViewed extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  RecentlyViewed({super.key});
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;

    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? AppColors.cardDarkColor.withValues(alpha: 0.6)
                      : AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 96,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.appBarIcolor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'The Grand Hall',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode
                                      ? AppColors.borderColor2
                                      : AppColors.textColor,
                            ),
                          ),
                          Text(
                            'Wedding',
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.subTitleColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: CircleAvatar(
                          radius: 8,
                          child: Image.asset(IconPath.vector2),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(EpVenueDetails());
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              isDarkMode
                                  ? AppColors.buttonColor.withValues(alpha: 0.1)
                                  : isFemale
                                  ? femaleColorController.selectedColor
                                      .withValues(alpha: 0.1)
                                  : AppColors.appBarIcolor.withValues(
                                    alpha: 0.1,
                                  ),
                          radius: 14,
                          child: Image.asset(
                            IconPath.frame,
                            color:
                                isDarkMode
                                    ? AppColors.buttonColor
                                    : isFemale
                                    ? femaleColorController.selectedColor
                                    : AppColors.iconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 16,
                        color: AppColors.subtitleColor2,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '15 March,2025',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtitleColor2,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.subtitleColor2,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'New York',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtitleColor2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
