// ignore_for_file: file_names

import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/image_path.dart';

class BookingRequest extends StatelessWidget {
  final String eventName;
  final DateTime? selectedDate;
  final int guestNumber;
  final String bookingStatus;

  const BookingRequest({
    super.key,
    required this.eventName,
    required this.selectedDate,
    required this.guestNumber,
    required this.bookingStatus,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<VenueOwnerProfileController>().isDarkMode.value;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: isDarkMode ? const Color(0xff32383D) : const Color(0xffEBEBEB),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.025,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    ImagePath.venuesHall,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      ImagePath.venuesHall,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$guestNumber Guests',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  IconPath.check,
                  width: 37,
                  height: 28,
                  fit: BoxFit.contain,
                  color: isDarkMode ? const Color(0xffD4AF37) : const Color(0xff003366),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: screenWidth * 0.035,
                  color: const Color(0xff8A8A8A),
                ),
                const SizedBox(width: 6),
                Text(
                  _formatDate(selectedDate),
                  style: getTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff767676),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 22,
                  width: screenWidth * 0.17,
                  decoration: BoxDecoration(
                    color: bookingStatus.toLowerCase() == 'accepted'
                        ? const Color(0xff003366)
                        : bookingStatus.toLowerCase() == 'pending'
                        ? const Color(0xffD4AF37)
                        : const Color(0xffCC0000),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      bookingStatus,
                      style: getTextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffE6EBF0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}