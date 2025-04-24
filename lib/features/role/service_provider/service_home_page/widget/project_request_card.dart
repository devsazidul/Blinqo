import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectRequestCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String time;
  final String logoPath;

  ProjectRequestCard({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.logoPath,
  });
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Card(
        elevation: 1.0,
        color:
            themeMode == ThemeMode.dark
                ? AppColors.textColor
                : AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(logoPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                      ),
                      Text(
                        location,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.indicatorColors,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        themeMode == ThemeMode.dark
                            ? AppColors.buttonColor.withValues(alpha: 0.10)
                            : AppColors.chatBackground,
                    child: Image.asset(
                      IconPath.upcomingicon,
                      width: 18,
                      height: 18,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(IconPath.upcomingcalendar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    date,
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.indicatorColors,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    time,
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.indicatorColors,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 25,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.buttonColor2,
                    ),
                    child: Center(
                      child: Text(
                        "Accept",
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
