import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/booking_details_section.dart';
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
    final PriceController controller = Get.put(PriceController());
    final BookingController bookingController = Get.put(BookingController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // implement the header
            BookingHeader(),
            SizedBox(height: 12),
            VenueDetailsSection(controller: controller),
            SizedBox(height: 40),
            // message section with container
            MessageButtonSection(),

            SizedBox(height: 40),
            Text(
              "Jhon's Birthday",
              style: getTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff003285),
              ),
            ),
            SizedBox(height: 20),
            BookingDetailsSection(),
            SizedBox(height: 24),

            // build the additional services
            Text(
              'Additional Services',
              style: getTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Color(0xffEBEBEB) : AppColors.textColor,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 12,
              children: [
                _buildAdditionalServices('Catering'),
                _buildAdditionalServices('Photography'),
                _buildAdditionalServices('Decoration'),
              ],
            ),

            // Seating Arrangement
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Seating Arrangement',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Image.asset(
              ImagePath.seatingArrangement,
              width: width * 0.9,
              height: height * 0.3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 12),
            DecorationDetailsSection(),
            SizedBox(height: 40),

            // condition check that if the booking status is "Booking Requests" or "In Progress" then show the action buttons
            if (bookingController.bookings[0].status == "Booking Requests" ||
                bookingController.bookings[0].status == "In Progress")
              _buildActionButtons(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Row(
      children: [
        SizedBox(width: 20),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Handle delete action
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xff151515) : Color(0x1A003366),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Color(0xff003366) : Colors.transparent,
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
                              ? Color(0xffEBEBEB)
                              : AppColors.buttonColor2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Handle accept action
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
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildAdditionalServices(String service) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:isDarkMode ? Color(0x1AD4AF37) : Color(0x1A003366),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        service,
        style: getTextStyle(
          color: isDarkMode ? Color(0xffD4AF37) : AppColors.iconColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
