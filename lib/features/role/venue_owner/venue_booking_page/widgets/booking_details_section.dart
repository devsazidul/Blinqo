import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BookingDetailsSection extends StatelessWidget {
  const BookingDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                style: getTextStylePoppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff003366),
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
        Text(label, style: getTextStylePoppins()),
        Text(
          value,
          style: getTextStylePoppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff333333),
          ),
        ),
      ],
    );
  }
}
