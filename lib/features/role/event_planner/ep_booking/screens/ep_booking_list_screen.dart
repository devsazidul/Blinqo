import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/ep_booking/controllers/ep_booking_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_booking/widgets/booking_empty_list_widget.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/booking_contner_card.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpBookingListScreen extends GetView<EpBookingController> {
  const EpBookingListScreen({super.key});

  @override
  EpBookingController get controller => Get.put(EpBookingController());

  void _showSortOptions(BuildContext context, bool isDarkMode) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    final double screenWidth = MediaQuery.of(context).size.width;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          Offset(offset.dx + button.size.width - 120, offset.dy),
          Offset(offset.dx + button.size.width, offset.dy + button.size.height),
        ),
        Offset.zero & Size(screenWidth, MediaQuery.of(context).size.height),
      ),
      items: [
        PopupMenuItem(
          child: Text(
            'Sort by Name',
            style: TextStyle(
              color:
                  isDarkMode ? AppColors.borderColor2 : const Color(0xFF003366),
            ),
          ),
          onTap: () => controller.sortByName(),
        ),
        PopupMenuItem(
          child: Text(
            'Sort by Date',
            style: TextStyle(
              color:
                  isDarkMode ? AppColors.borderColor2 : const Color(0xFF003366),
            ),
          ),
          onTap: () => controller.sortByDate(),
        ),
        PopupMenuItem(
          child: Text(
            'Sort by Day',
            style: TextStyle(
              color:
                  isDarkMode ? AppColors.borderColor2 : const Color(0xFF003366),
            ),
          ),
          onTap: () => controller.sortByDay(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    final pickColorController = Get.find<PickColorController>();
    // Get the screen size using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthFactor =
        screenWidth /
        375; // For example, base width of 375 (e.g., for iPhone 6)
    double screenHeightFactor =
        screenHeight / 812; // Base height (iPhone 6 screen height)

    bool isBookingEmpty = false;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,

      appBar: CustomAppBarWidget(title: "Booking", isBackButton: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0 * screenWidthFactor),
        child: Visibility(
          visible: isBookingEmpty,
          replacement: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Booking List',
                      style: TextStyle(
                        color:
                            isDarkMode
                                ? AppColors.borderColor2
                                : const Color(0xFF003366),
                        fontSize: 20 * screenWidthFactor,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () => _showSortOptions(context, isDarkMode),
                      child: Container(
                        height: 36 * screenHeightFactor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * screenWidthFactor,
                          vertical: 3 * screenHeightFactor,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color:
                                  isDarkMode
                                      ? AppColors.borderColor2
                                      : const Color(0xFF003366),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sort by',
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? AppColors.borderColor2
                                        : const Color(0xFF003366),
                                fontSize: 12 * screenWidthFactor,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 4 * screenWidthFactor),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 16 * screenWidthFactor,
                              color:
                                  isDarkMode
                                      ? AppColors.borderColor2
                                      : const Color(0xFF003366),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ---------
                SizedBox(height: 20 * screenHeightFactor),
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
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.bookings.length,
                    itemBuilder: (_, index) {
                      final booking = controller.bookings[index];
                      return BookingContainerCard(
                        eventName: booking['eventName'],
                        venue: booking['venue'],
                        totalCost: booking['totalCost'],
                        date: booking['date'],
                      );
                    },
                  ),
                ),

                SizedBox(height: 20 * screenHeightFactor),
              ],
            ),
          ),
          child: BookingEmptyListWidget(
            screenWidthFactor: screenWidthFactor,
            screenHeightFactor: screenHeightFactor,
            pickColorController: pickColorController,
          ),
        ),
      ),

      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 20.0 * screenWidthFactor),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         // emty booking list
      //         BookingEmptyListWidget(
      //           screenWidthFactor: screenWidthFactor,
      //           screenHeightFactor: screenHeightFactor,
      //           pickColorController: pickColorController,
      //         ),

      //         // booking list
      //         Text(
      //           "In Progress",
      //           style: getTextStyle(
      //             fontSize: 16 * screenWidthFactor,
      //             fontWeight: FontWeight.w600,
      //             color:
      //                 isDarkMode
      //                     ? AppColors.borderColor2
      //                     : pickColorController.isFemale.value
      //                     ? pickColorController.selectedColor
      //                     : AppColors.buttonColor2,
      //           ),
      //         ),
      //         SizedBox(height: 10 * screenHeightFactor),
      //         ListView.builder(
      //           itemBuilder: (_, index) {
      //             return BookingContainerCard();
      //           },
      //           itemCount: 5,
      //           shrinkWrap: true,
      //           physics: NeverScrollableScrollPhysics(),
      //         ),

      //         SizedBox(height: 20 * screenHeightFactor),
      //       ],
      //     ),
      //   ),
      // ),
    );
    // });
  }
}
