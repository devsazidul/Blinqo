// ignore_for_file: must_be_immutable
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBer extends StatelessWidget {
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );
  final ProfileController themeController = Get.put(ProfileController());
  SearchBer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: getTextStyle(
              color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
            ),
            onChanged: (value) {},
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 10,
              ),
              hintText: 'Search venues & services...',
              hintStyle: getTextStyle(
                color:
                    isDarkMode
                        ? AppColors.chatBackground
                        : AppColors.subTextColor2,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              filled: true,

              fillColor:
                  isDarkMode ? AppColors.cardDarkColor : AppColors.primary,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoute.getfilterDetailsScreen());
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  isDarkMode
                      ? AppColors.cardDarkColor
                      : AppColors.iconBackground,
            ),
            child: Icon(Icons.tune, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
