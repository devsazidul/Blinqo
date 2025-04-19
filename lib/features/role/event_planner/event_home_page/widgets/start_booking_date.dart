import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../home/controller/booking_controller.dart';

class StartBookingDate extends StatelessWidget {
  const StartBookingDate({super.key, required this.bookingController});

  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set Date',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF003285),
          ),
        ),

        GestureDetector(
          onTap: () => bookingController.selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE6E6E6), width: 1),
              color: Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: AppColors.iconColor),
                SizedBox(width: 4),
                Column(
                  children: [
                    Text(
                      'Select a day',
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Obx(
                      () => Text(
                        bookingController.getFormattedDate(),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF003285),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                Transform.rotate(
                  angle: 256,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.iconColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
