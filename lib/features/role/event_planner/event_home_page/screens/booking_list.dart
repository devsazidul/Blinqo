import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/booking_contner_card.dart';
import '../widgets/booking_emtry.dart';

class BookingList extends StatelessWidget {
  const BookingList({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    final PickColorController pickColorController = Get.find();
    // Get the screen size using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthFactor =
        screenWidth /
        375; // For example, base width of 375 (e.g., for iPhone 6)
    double screenHeightFactor =
        screenHeight / 812; // Base height (iPhone 6 screen height)

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,

        title: Text(
          'Booking',
          style: getTextStyle(
            fontSize: 18 * screenWidthFactor,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
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
                screenWidthFactor: screenWidthFactor,
                screenHeightFactor: screenHeightFactor,
                pickColorController: pickColorController,
              ),

              // booking list
              Text(
                "In Progress",
                style: getTextStyle(
                  fontSize: 16 * screenWidthFactor,
                  fontWeight: FontWeight.w600,
                  color:
                      isDarkMode
                          ? AppColors.borderColor2
                          : pickColorController.isFemale.value
                          ? pickColorController.selectedColor
                          : AppColors.buttonColor2,
                ),
              ),
              SizedBox(height: 10 * screenHeightFactor),
              ListView.builder(
                itemBuilder: (_, index) {
                  return BookingContainerCard();
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
    // });
  }
}
