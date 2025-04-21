import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/widget/revies_card.dart'
    show ReviesCard;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import '../../../home/controller/booking_controller.dart';
import '../../widgets/enent_type_dopdown_button.dart';
import '../../widgets/stark_booking_additional_services.dart';
import '../../widgets/stark_booking_set_start_time_and_endtime.dart';
import '../../widgets/start-booking_decoration_image.dart';
import '../../widgets/start_booking_button.dart';
import '../../widgets/start_booking_date.dart';
import '../../widgets/start_booking_number_of_guests.dart';
import '../../widgets/start_booking_text_or_button.dart';
import '../../widgets/start_booking_textfrom.dart';
import '../widget/anemities_item_card.dart';
import '../widget/shearch_start_booking_page.dart';

class SearchStartBooking extends StatelessWidget {
  const SearchStartBooking({super.key});

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

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              ShearchStartBookingPage(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    ReviesCard(),

                    AmenitiesItemCard(bookingController: bookingController),

                    SizedBox(height: screenHeight * 0.02),

                    StartBookingTextFrom(
                      screenHeight: screenHeight,
                      bookingController: bookingController,
                      themeMode: themeMode,
                    ),
                    //
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
            ],
          ),
        ),
      );
    });
  }
}
