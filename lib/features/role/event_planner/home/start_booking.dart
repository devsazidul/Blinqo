import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/search_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/enent_type_dopdown_button.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/stark_booking_additional_services.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/stark_booking_set_start_time_and_endtime.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/start-booking_decoration_image.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/start_booking_button.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/start_booking_date.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/start_booking_number_of_guests.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/start_booking_text_or_button.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/start_booking_textfrom.dart';
import 'package:blinqo/features/role/event_planner/home/wigate/custom_appbar.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_indicator_package/step_indicator.dart';

import 'controller/booking_controller.dart';
import 'wigate/start_booking_shearh_bar.dart';

class StartBooking extends StatelessWidget {
  const StartBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final PickColorController pickColorController = Get.find();
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final bookingController = Get.put(BookingController());
    final controller = Get.find<ProfileController>();
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.buttonBuckdownColor2,
        appBar: CustomAppBar(
          screenWidth: screenWidth,
          title: "Start Booking",
          themeMode: themeMode,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
            ), // Horizontal padding based on screen width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StartBookingShearshBar(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  themeMode: themeMode,
                  onTap: () {
                    // Get.to(SearchStartBooking());
                    Get.to(SearchDetailsScreen());
                  },
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Booking Timeline',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? Color(0xffD4AF37)
                              : pickColorController.isFemale.value
                              ? pickColorController.selectedColor
                              : Color(0xff003285),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                StepIndicator(
                  activeColor:
                      themeMode == ThemeMode.dark
                          ? Color(0xffD4AF37)
                          : pickColorController.isFemale.value
                          ? pickColorController.selectedColor
                          : Color(0xff003285),
                  activeLineColor:
                      themeMode == ThemeMode.dark
                          ? Color(0xffD4AF37)
                          : pickColorController.isFemale.value
                          ? pickColorController.selectedColor
                          : Color(0xff003285),
                  allowCircleTap: false,
                  circleRadius: 18,
                  paddingHorizontal: 60,
                  showNavigationButtons: false,
                ),
                SizedBox(height: 40),
                StartBookingTextFrom(
                  screenHeight: screenHeight,
                  bookingController: bookingController,
                  themeMode: themeMode,
                  pickColorController: pickColorController,
                ),

                SizedBox(height: screenHeight * 0.02),
                StartBookingDate(
                  bookingController: bookingController,
                  themeMode: themeMode,
                  pickColorController: pickColorController,
                ),

                SizedBox(height: screenHeight * 0.02),
                StarkBookingSetStartTimeOrEndTime(
                  bookingController: bookingController,
                  themeMode: themeMode,
                  pickColorController: pickColorController,
                ),
                SizedBox(height: screenHeight * 0.02),
                StartBookingNumberOfGuests(
                  screenHeight: screenHeight,
                  bookingController: bookingController,
                  themeMode: themeMode,
                  pickColorController: pickColorController,
                ),
                SizedBox(height: screenHeight * 0.02),

                EventTypeDopdownButton(
                  bookingController: bookingController,
                  screenHeight: screenHeight,
                  themeMode: themeMode,
                  pickColorController: pickColorController,
                ),
                SizedBox(height: screenHeight * 0.02),
                StartBookingDecorationImage(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  themeMode: themeMode,
                ),
                StartBookingTextOrButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  themeMode: themeMode,
                  pickColorController: pickColorController,
                ),

                SizedBox(height: screenHeight * 0.02),

                StarkBookingAdditionalServices(themeMode: themeMode),
                SizedBox(height: screenHeight * 0.05),
                StartBookingButton(
                  onTapContinue: () {
                    //Get.to(() => const SearchStartBooking());
                    //Navigator.pushNamed(context, SearchStartBooking.routeName);
                    //Get.toNamed(AppRoute.getsearchStartBooking());
                    Get.to(SearchStartBooking());
                  },

                  screenHeight: screenHeight,
                  themeMode: themeMode,
                ),

                SizedBox(height: screenHeight * 0.06),
              ],
            ),
          ),
        ),
      );
    });
  }
}
