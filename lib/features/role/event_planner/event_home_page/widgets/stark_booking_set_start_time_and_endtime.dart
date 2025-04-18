import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../home/controller/booking_controller.dart';

class StarkBookingSetStartTimeOrEndTime extends StatelessWidget {
  const StarkBookingSetStartTimeOrEndTime({
    super.key,
    required this.bookingController,
  });

  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Time',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF003285),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => bookingController.selectStartTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE6E6E6), width: 1),
                    color: Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: AppColors.iconColor),
                      SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start time',
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Obx(
                            () => Text(
                              bookingController.getFormattedStartTime(context),
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF003285),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
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
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => bookingController.selectEndTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE6E6E6), width: 1),
                    color: Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: AppColors.iconColor),
                      SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End time',
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Obx(
                            () => Text(
                              bookingController.getFormattedEndTime(context),
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF003285),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
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
            ),
          ],
        ),
      ],
    );
  }
}
