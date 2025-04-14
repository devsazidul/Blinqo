import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../controllers/booking_controller.dart';
import '../widgets/booking_header_section.dart';

class BookingDetailsPage extends StatelessWidget {
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Grand Hall',
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '(345 reviews)',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFABB7C2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.textFrieldDarkColor,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'New York, USA',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _priceButton(controller);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x1A003366),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 24,
                              color: AppColors.iconColor,
                            ),
                            Obx(() {
                              return controller.price.value.isNotEmpty
                                  ? Text(
                                    controller.price.value,
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.iconColor,
                                    ),
                                  )
                                  : Text(
                                    'Set Price',
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.iconColor,
                                    ),
                                  );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // message section with container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x1A003366),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.message, size: 24, color: AppColors.iconColor),
                      SizedBox(width: 12),
                      Text(
                        'Message',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
            _buildEventDetails(),
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
                spacing: 8,
                children: [
                  _buildAdditionalServices('Catering'),
                  _buildAdditionalServices('Photography'),
                  _buildAdditionalServices('Decoration'),
                ],
              ),

            // Seating Arrangement
            SizedBox(height: 40),
            Text(
              'Seating Arrangement',
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              ImagePath.seatingArrangement,
              width: width * 0.9,
              height: height * 0.3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Decoration',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor2,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Table Shape', 'Round'),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Flower Color', 'Red'),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Seating Style', 'Banquet'),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Fragrance', 'Sweet'),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Lighting Styles', 'Warm Yellow',),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Tablecloth Colors', 'White'),
                      SizedBox(height: 16),
                      _buildDecorationDetailsRow('Stage Decor', 'LED Backdrops',),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // build the additional services
  Widget _buildAdditionalServices(String service) {
    return Chip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      side: BorderSide.none,
      label: Text(
        service,
        style: getTextStyle(
          color: AppColors.iconColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Color(0x1A003366),
    );
  }

  Widget _buildEventDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.buttonColor2,
                ),
              ),
              SizedBox(height: 16),
              _buildBookingDetailsRow('Organizer', 'John Doe Events'),
              SizedBox(height: 16),
              _buildBookingDetailsRow('Date', '12th March 2024'),
              SizedBox(height: 16),
              _buildBookingDetailsRow('Time', '6:00 PM - 11:00 PM'),
              SizedBox(height: 16),
              _buildBookingDetailsRow('Guests', '150'),
              SizedBox(height: 16),
              _buildBookingDetailsRow('Event Type', 'Birthday'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingDetailsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDecorationDetailsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff767676),
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.iconColor,
          ),
        ),
      ],
    );
  }

  void _priceButton(PriceController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
        content: TextField(
          onChanged:
              (value) => controller.price.value = value,
          decoration: InputDecoration(
            hintText: 'Enter price',
            label: Text('Set A Price'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  () => controller.submitPrice(
                controller.price.value,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Submit',
                style: getTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
