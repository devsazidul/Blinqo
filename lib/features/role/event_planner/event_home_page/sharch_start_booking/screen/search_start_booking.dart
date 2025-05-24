import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/ep_common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/widget/event_planner_custom_calendar.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/widget/revies_card.dart'
    show ReviesCard;
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/review_booking/screen/review_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_indicator_package/step_indicator.dart';

import '../../../ep_home/controller/booking_controller.dart';
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
import '../widget/event_status_label.dart';
import '../widget/shearch_start_booking_page.dart';

final ValueNotifier<List<DateTime>> selectedDatesNotifier =
    ValueNotifier<List<DateTime>>([
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ]);

class SearchStartBooking extends StatelessWidget {
  static const String routeName = '/search_start_booking_01';
  const SearchStartBooking({super.key});

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

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShearchStartBookingPage(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    ReviesCard(themeMode: themeMode),

                    AmenitiesItemCard(
                      bookingController: bookingController,
                      themeMode: themeMode,
                    ),

                    SizedBox(height: screenHeight * 0.02),
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
                      circleRadius: 18,
                      paddingHorizontal: 60,
                      showNavigationButtons: false,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    StartBookingTextFrom(
                      screenHeight: screenHeight,
                      bookingController: bookingController,
                      themeMode: themeMode,
                      pickColorController: pickColorController,
                    ),
                    //
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

                    Center(
                      child: Text(
                        'Availability',
                        style: getTextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.darkBackgroundColor
                                : AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            themeMode == ThemeMode.dark
                                ? Border.all(color: AppColors.borderColor2)
                                : null,
                      ),
                      child: EventPlannerCustomCalendar(
                        height: Get.height * 0.44,
                        selectedDatesNotifier: selectedDatesNotifier,
                        themeMode: themeMode,
                        selectedColor:
                            themeMode == ThemeMode.dark ||
                                    !pickColorController.isFemale.value
                                ? const Color(0xffF0C020)
                                : pickColorController.selectedColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EventStatusLabel(
                          themeMode: themeMode,
                          color: Color(0xffC0C0C0),
                          label: 'Booked',
                        ),
                        SizedBox(height: 8),
                        EventStatusLabel(
                          themeMode: themeMode,
                          color:
                              themeMode == ThemeMode.dark ||
                                      !pickColorController.isFemale.value
                                  ? Color(0xffF0C020)
                                  : pickColorController.selectedColor,
                          label: 'Selected',
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 22,
                        top: 12,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            themeMode == ThemeMode.dark
                                ? Color(0xff32383D)
                                : AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ValueListenableBuilder<List<DateTime>>(
                        valueListenable: selectedDatesNotifier,
                        builder: (context, selectedDates, _) {
                          String formattedDate = '';
                          if (selectedDates.isNotEmpty) {
                            DateTime selectedDate = selectedDates.first;
                            formattedDate = DateFormat('d MMMM yyyy').format(
                              selectedDate,
                            ); // Format as "1 November 2022"
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Selected Date",
                                    style: getTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          themeMode == ThemeMode.dark
                                              ? AppColors.borderColor2
                                              : AppColors.textColor,
                                    ),
                                  ),
                                  Text(
                                    formattedDate.isNotEmpty
                                        ? formattedDate
                                        : "No Date Selected", // Show selected date or default text
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          themeMode == ThemeMode.dark ||
                                                  !pickColorController
                                                      .isFemale
                                                      .value
                                              ? AppColors.reviesStarColor
                                              : pickColorController
                                                  .selectedColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8), // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Price",
                                    style: getTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          themeMode == ThemeMode.dark
                                              ? AppColors.borderColor2
                                              : AppColors.textColor,
                                    ),
                                  ),
                                  Text(
                                    "\$99.99", // Example price
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          themeMode == ThemeMode.dark ||
                                                  !pickColorController
                                                      .isFemale
                                                      .value
                                              ? AppColors.reviesStarColor
                                              : pickColorController
                                                  .selectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
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
                        //Navigator.pushNamed(context, ReviewBooking.routeName);
                        Get.to(ReviewBooking());
                      },
                      screenHeight: screenHeight,
                      themeMode: themeMode,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: EpBottomNavBarWidget(),
      );
    });
  }
}
