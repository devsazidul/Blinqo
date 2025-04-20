import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/home/wigate/custom_appbar.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../event_home_page/widgets/enent_type_dopdown_button.dart';
import '../event_home_page/widgets/stark_booking_additional_services.dart';
import '../event_home_page/widgets/stark_booking_set_start_time_and_endtime.dart';
import '../event_home_page/widgets/start-booking_decoration_image.dart';
import '../event_home_page/widgets/start_booking_button.dart';
import '../event_home_page/widgets/start_booking_date.dart';
import '../event_home_page/widgets/start_booking_number_of_guests.dart';
import '../event_home_page/widgets/start_booking_text_or_button.dart';
import '../event_home_page/widgets/start_booking_textfrom.dart';
import 'controller/booking_controller.dart';
import 'wigate/start_booking_shearh_bar.dart';

class StartBooking extends StatelessWidget {
  const StartBooking({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final bookingController = Get.put(BookingController());
    final controller = Get.find<SpProfileController>();
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
                ),

                StartBookingTextFrom(
                  screenHeight: screenHeight,
                  bookingController: bookingController,
                  themeMode: themeMode,
                ),

                SizedBox(height: screenHeight * 0.02),
                StartBookingDate(
                  bookingController: bookingController,
                  themeMode: themeMode,
                ),

                SizedBox(height: screenHeight * 0.02),
                StarkBookingSetStartTimeOrEndTime(
                  bookingController: bookingController,
                  themeMode: themeMode,
                ),
                SizedBox(height: screenHeight * 0.02),
                StartBookingNumberOfGuests(
                  screenHeight: screenHeight,
                  bookingController: bookingController,
                  themeMode: themeMode,
                ),
                SizedBox(height: screenHeight * 0.02),

                EventTypeDopdownButton(
                  bookingController: bookingController,
                  screenHeight: screenHeight,
                  themeMode: themeMode,
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
                ),

                SizedBox(height: screenHeight * 0.02),

                StarkBookingAdditionalServices(themeMode: themeMode),

                SizedBox(height: screenHeight * 0.05),
                StartBookingButton(
                  screenHeight: screenHeight,
                  themeMode: themeMode,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
