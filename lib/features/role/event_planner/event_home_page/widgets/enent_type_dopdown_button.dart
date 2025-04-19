import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/controller/booking_controller.dart';

class EventTypeDopdownButton extends StatelessWidget {
  const EventTypeDopdownButton({
    super.key,
    required this.screenHeight,
    required this.bookingController,
  });

  final double screenHeight;
  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    // List of event types to display in the dropdown
    List<String> countries = [
      'Birthday Party',
      'Wedding',
      'Corporate Event',
      'Bachelor Party',
      'Anniversary',
      'Others',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Type',
          style: getTextStyle(
            color: AppColors.dopdownTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),

        // Dropdown for selecting event type with no icon, only text
        SizedBox(
          height: 52,
          width: 343,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 7.0.h,
              ),
              labelText: 'Select Event Type',
              labelStyle: getTextStyle(
                color: AppColors.labalStyleColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  color: AppColors.dopdownTextColor,
                  width: 1,
                ),
              ),
              // No icon here, just text and border
            ),
            value:
                bookingController.selectedCountry.value.isNotEmpty
                    ? bookingController.selectedCountry.value
                    : null, // Use the selected event type or set null initially
            items:
                countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: getTextStyle(
                        color: AppColors.dopdownTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                // Update the selected event type in the controller
                bookingController.selectedCountry.value = newValue;
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an event type';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
