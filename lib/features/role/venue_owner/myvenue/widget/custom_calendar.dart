import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/venue_details_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class CustomCalendar extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final List<BookedDate> bookedDates;
  final double height;

  const CustomCalendar({
    super.key,
    required this.selectedDatesNotifier,
    required this.bookedDates,
    this.height = 370,
  });

  @override
  Widget build(BuildContext context) {

    final bool isDarkMode = Get.find<VenueOwnerProfileController>().isDarkMode.value;

    return ValueListenableBuilder<List<DateTime>>(
      valueListenable: selectedDatesNotifier,
      builder: (context, selectedDates, _) {
        // Create EventList for booked and selected dates
        final EventList<Event> markedDatesMap = EventList<Event>(
          events: {
            // Add booked dates
            for (var booked in bookedDates)
              if (booked.selectedDate != null)
                DateTime(booked.selectedDate!.year, booked.selectedDate!.month, booked.selectedDate!.day): [
                  Event(
                    date: DateTime(booked.selectedDate!.year, booked.selectedDate!.month, booked.selectedDate!.day),
                    title: 'Booked',
                  ),
                ],
            // Add selected dates
            for (var date in selectedDates)
              DateTime(date.year, date.month, date.day): [
                Event(
                  date: DateTime(date.year, date.month, date.day),
                  title: 'Selected',
                ),
              ],
          },
        );

        return CalendarCarousel(
          daysTextStyle: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
          headerTextStyle: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff615E83),
          ),
          onDayPressed: (date, events) {
            // Prevent selecting booked dates
            final isBooked = bookedDates.any(
                  (booked) =>
              booked.selectedDate != null &&
                  booked.selectedDate!.year == date.year &&
                  booked.selectedDate!.month == date.month &&
                  booked.selectedDate!.day == date.day,
            );
            if (isBooked) return; // Do nothing if the date is booked

            final normalizedDate = DateTime(date.year, date.month, date.day);
            if (selectedDates.contains(normalizedDate)) {
              selectedDatesNotifier.value = selectedDates.where((d) => d != normalizedDate).toList();
            } else {
              selectedDatesNotifier.value = List.from(selectedDates)..add(normalizedDate);
            }
          },
          markedDatesMap: markedDatesMap,
          markedDateShowIcon: true,
          markedDateIconBuilder: (event) {
            final date = DateTime(event.date.year, event.date.month, event.date.day);
            final isBooked = bookedDates.any(
                  (booked) =>
              booked.selectedDate != null &&
                  booked.selectedDate!.year == date.year &&
                  booked.selectedDate!.month == date.month &&
                  booked.selectedDate!.day == date.day,
            );
            if (isBooked) {
              return _buildCircle(event.date.day, Colors.red); // Booked dates in red
            } else {
              // Selected dates
              return _buildCircle(
                event.date.day,
                selectedDatesNotifier.value.indexOf(date) == 0
                    ? (isDarkMode ? const Color(0xff34C759) : const Color(0xff19480B)) // First selected date
                    : const Color(0xff0066CC), // Other selected dates
              );
            }
          },
          todayBorderColor: Colors.transparent,
          todayButtonColor: Colors.transparent,
          selectedDayButtonColor: const Color(0xff0066CC),
          selectedDayTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff9291A5),
          ),
          weekdayTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff9291A5),
          ),
          thisMonthDayBorderColor: Colors.transparent,
          daysHaveCircularBorder: false,
          weekFormat: false,
          height: height,
        );
      },
    );
  }

  Widget _buildCircle(int day, Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$day',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}