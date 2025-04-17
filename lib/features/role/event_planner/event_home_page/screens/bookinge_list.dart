import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import '../widgets/booking_contner_card.dart';
import '../widgets/booking_emtry.dart';

class BookingeList extends StatelessWidget {
  const BookingeList({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthFactor =
        screenWidth /
        375; // For example, base width of 375 (e.g., for iPhone 6)
    double screenHeightFactor =
        screenHeight / 812; // Base height (iPhone 6 screen height)

    final spProfileController = Get.find<SpProfileController>();
    /*
  final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

*/
    return Obx(() {
      final themeMode =
          spProfileController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          forceMaterialTransparency: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 20.0 * screenWidthFactor),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Color(0xff000000).withValues(alpha: 0.15),
                child: Image.asset(
                  IconPath.arrowLeftAlt,
                  width: 16 * screenWidthFactor,
                  height: 12 * screenHeightFactor,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.appBarArrowIconColor,
                ),
              ),
            ),
          ),
          title: Text(
            'Booking',
            style: getTextStyle(
              fontSize: 18 * screenWidthFactor,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.borderColor2
                      : AppColors.textColor,
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 * screenWidthFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // emty booking list
                BookingEmtry(
                  themeMode: themeMode,
                  screenWidthFactor: screenWidthFactor,
                  screenHeightFactor: screenHeightFactor,
                ),

                // booking list
                Text(
                  "In Progress",
                  style: getTextStyle(
                    fontSize: 16 * screenWidthFactor,
                    fontWeight: FontWeight.w600,
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.borderColor2
                            : AppColors.buttonColor2,
                  ),
                ),
                SizedBox(height: 10 * screenHeightFactor),
                ListView.builder(
                  itemBuilder: (_, index) {
                    return BookingContainerCard(themeMode: themeMode);
                  },
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),

                SizedBox(height: 20 * screenHeightFactor),
              ],
            ),
          ),
        ),
      );
    });
  }
}
