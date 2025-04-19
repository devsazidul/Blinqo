import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailsScreen extends StatelessWidget {
  final themeController = Get.find<SpProfileController>();

  SearchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBerSection(themeMode: themeMode),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      Text(
                        'Clear All',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.access_time,
                      color: AppColors.timeicon,
                      size: 27,
                    ),
                    title: Text(
                      'Emerald Ballroom',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Clearwater, Fl',
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.timeicon,
                      ),
                    ),
                  ),
                  Divider(height: 1, color: AppColors.borderColor2),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.access_time,
                      color: AppColors.timeicon,
                      size: 27,
                    ),
                    title: Text(
                      'Emerald Ballroom',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Clearwater, Fl',
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.timeicon,
                      ),
                    ),
                  ),
                  Divider(height: 1, color: AppColors.borderColor2),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.access_time,
                      color: AppColors.timeicon,
                      size: 27,
                    ),
                    title: Text(
                      'Emerald Ballroom',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Clearwater, Fl',
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.timeicon,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recently Viewed',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 90,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                child: Row(
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
