import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/controller/booking_controller.dart';

class EventTypeDopdownButton extends StatelessWidget {
  const EventTypeDopdownButton({
    super.key,
    required this.screenHeight,
    required this.bookingController,
    required this.themeMode,
    this.pickColorController,
  });

  final double screenHeight;
  final BookingController bookingController;
  final ThemeMode themeMode;
  final PickColorController? pickColorController;

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
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : pickColorController?.isFemale.value ?? false
                    ? pickColorController?.selectedColor ??
                        AppColors.dopdownTextColor
                    : AppColors.dopdownTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),

        // Dropdown for selecting event type with no icon, only text
        SizedBox(
          height: 52,
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            dropdownColor:
                themeMode == ThemeMode.dark
                    ? AppColors.darkBackgroundColor
                    : AppColors.backgroundColor,
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
                borderRadius: BorderRadius.circular(4),
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
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.backgroundColor
                                : AppColors.dopdownTextColor,
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
