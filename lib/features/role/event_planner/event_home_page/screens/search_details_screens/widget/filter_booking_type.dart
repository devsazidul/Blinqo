import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingType extends StatelessWidget {
  BookingType({super.key, required this.searchDetailsController});
  final SearchDetailsController searchDetailsController;
  final ProfileController themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Row(
      children: [
        Obx(
          () => Expanded(
            child: Radio(
              toggleable: true,
              activeColor:
                  isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              value: 1,
              groupValue: searchDetailsController.selectedBookingValue.value,
              onChanged: (int? value) {
                if (value != null) {
                  searchDetailsController.toggleBooking();
                }
              },
            ),
          ),
        ),
        Text(
          'Instant booking',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
        ),
        Obx(
          () => Expanded(
            child: Radio(
              toggleable: true,
              activeColor:
                  isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              value: 0,
              groupValue: searchDetailsController.selectedBookingValue.value,
              onChanged: (int? value) {
                if (value != null) {
                  searchDetailsController.toggleBooking();
                }
              },
            ),
          ),
        ),
        Text(
          'request-based booking',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
