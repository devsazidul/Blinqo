import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/no_bookings_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/booking_details_section.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/booking_shimmer.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/decoration_details_section.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/message_button_section.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/venue_details_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';
import '../widgets/booking_header_section.dart';

class BookingDetailsPage extends StatelessWidget {
  static const String name = '/booking_details_page';

  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final BookingController bookingController = Get.put(BookingController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      body: Obx(() {
        if (bookingController.isLoading.value) {
          return const BookingShimmer();
        }

        if (bookingController.bookingResponse.value == null) {
          return const NoBookingsView();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // implement the header
              const BookingHeader(),
              const SizedBox(height: 12),
              VenueDetailsSection(),
              const SizedBox(height: 40),
              // message section with container
              const MessageButtonSection(),

              const SizedBox(height: 40),
              Text(
                bookingController.requestedBookings.isNotEmpty
                    ? bookingController.requestedBookings[0].eventName ??
                        "No Event Name"
                    : "No Event Name",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color:
                      isDarkMode
                          ? const Color(0xffEBEBEB)
                          : const Color(0xff003285),
                ),
              ),
              const SizedBox(height: 20),
              const BookingDetailsSection(),
              const SizedBox(height: 24),

              // build the additional services
              Text(
                'Additional Services',
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color:
                      isDarkMode
                          ? const Color(0xffEBEBEB)
                          : AppColors.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                children: [
                  _buildAdditionalServices('Catering'),
                  _buildAdditionalServices('Photography'),
                  _buildAdditionalServices('Decoration'),
                ],
              ),

              // Seating Arrangement
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Seating Arrangement',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:
                          isDarkMode
                              ? const Color(0xffEBEBEB)
                              : const Color(0xff333333),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Image.asset(
                ImagePath.seatingArrangement,
                width: width * 0.9,
                height: height * 0.3,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              const DecorationDetailsSection(),
              const SizedBox(height: 40),

              // condition check that if the booking status is "REQUESTED" or "PENDING" then show the action buttons
              if (bookingController.requestedBookings.isNotEmpty &&
                  (bookingController.requestedBookings[0].bookingStatus ==
                          "REQUESTED" ||
                      bookingController.requestedBookings[0].bookingStatus ==
                          "PENDING"))
                _buildActionButtons(bookingController),
              const SizedBox(height: 100),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons(BookingController controller) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Row(
      children: [
        const SizedBox(width: 20),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (controller.requestedBookings.isNotEmpty) {
                controller.rejectBooking(
                  controller.requestedBookings[0].id ?? '',
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? const Color(0xff151515)
                        : const Color(0x1A003366),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isDarkMode ? const Color(0xff003366) : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Delete',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color:
                          isDarkMode
                              ? const Color(0xffEBEBEB)
                              : AppColors.buttonColor2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (controller.requestedBookings.isNotEmpty) {
                controller.acceptBooking(
                  controller.requestedBookings[0].id ?? '',
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.iconColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Accept',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildAdditionalServices(String service) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0x1AD4AF37) : const Color(0x1A003366),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        service,
        style: getTextStyle(
          color: isDarkMode ? const Color(0xffD4AF37) : AppColors.iconColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
