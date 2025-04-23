// ignore_for_file: must_be_immutable
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBer extends StatelessWidget {
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );

  final ThemeMode themeMode;
  SearchBer({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 10,
              ),
              hintText: 'Search venues & services...',
              hintStyle: getTextStyle(
                color:
                    themeMode == ThemeMode.dark
                        ? Color.fromARGB(255, 198, 202, 206)
                        : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              suffixIcon: Icon(
                Icons.mic_none,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.secondary
                        : AppColors.buttonColor2,
              ),
              fillColor:
                  themeMode == ThemeMode.dark
                      ? AppColors.textFrieldDarkColor
                      : AppColors.primary,

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
              color: AppColors.iconBackground,
            ),
            child: Icon(Icons.tune, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
