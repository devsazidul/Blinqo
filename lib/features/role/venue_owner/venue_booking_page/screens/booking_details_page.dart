import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
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
    final PriceController controller = Get.put(PriceController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                color: Color(0xff003285),
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
                color: AppColors.textColor,
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
                    color: Color(0xff333333),
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

            // Accept and Delete buttons
            _buildActionButtons(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
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
                color: Color(0x1A003366),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Delete',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.buttonColor2,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0x1A003366),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        service,
        style: getTextStyle(
          color: AppColors.iconColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
