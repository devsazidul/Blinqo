import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/recently_viewed.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailsScreen extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());

  SearchDetailsScreen({super.key});
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBer(),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode
                                ? AppColors.borderColor2
                                : AppColors.textColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        searchDetailsController.clearAll();
                      },
                      child: Text(
                        'Clear All',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
                searchDetailsController.clear == false
                    ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColors.borderColor2,
                          thickness: 0.5,
                        );
                      },
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
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
                              color:
                                  isDarkMode
                                      ? AppColors.timeicon
                                      : AppColors.textColor,
                            ),
                          ),
                          subtitle: Text(
                            'Clearwater, Fl',
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color:
                                  isDarkMode
                                      ? AppColors.timeicon
                                      : AppColors.textColor,
                            ),
                          ),
                        );
                      },
                    )
                    : SizedBox(),
                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recently Viewed',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode
                                ? AppColors.borderColor2
                                : AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    RecentlyViewed(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
