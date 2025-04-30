import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/constants/colors.dart'; // Import for date formatting

class EventPlannerCustomCalendar extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final double height;
  final ThemeMode themeMode;
  final Color selectedColor;
  final Color bookedColor;

  const EventPlannerCustomCalendar({
    super.key,
    required this.selectedDatesNotifier,

    this.height = 320,
    required this.themeMode,
    this.selectedColor = const Color(0xffF0C020),
    this.bookedColor = const Color(0xffC0C0C0),
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DateTime>>(
      valueListenable: selectedDatesNotifier,
      builder: (context, selectedDates, _) {
        // Format the selected date (if any)
        String formattedDate = '';
        if (selectedDates.isNotEmpty) {
          DateTime selectedDate = selectedDates.first;
          formattedDate = DateFormat(
            'd MMMM yyyy',
          ).format(selectedDate); // Day Month Year format
        }

        return Column(
          children: [
            if (formattedDate.isNotEmpty)
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     formattedDate,
              //     style: getTextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600,
              //       color:
              //           themeMode == ThemeMode.dark
              //               ? AppColors.cardsubtextColor
              //               : AppColors.textColor,
              //     ),
              //   ),
              // ),
              CalendarCarousel(
                daysTextStyle: TextStyle(
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : Color(0xff1D1C2B),
                ),
                headerTextStyle: getTextStyle(
                  color: Color(0xff615E83),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                iconColor: Color(0xff9291A5),
                onDayPressed: (date, events) {
                  if (selectedDates.isEmpty) {
                    selectedDatesNotifier.value = [date];
                  } else if (selectedDates.contains(date)) {
                    selectedDatesNotifier.value =
                        selectedDates.where((d) => d != date).toList();
                  } else {
                    selectedDatesNotifier.value = List.from(selectedDates)
                      ..add(date);
                  }
                },
                markedDatesMap: EventList(
                  events: {
                    for (var date in selectedDates) date: [Event(date: date)],
                  },
                ),
                markedDateShowIcon: true,
                markedDateIconBuilder: (event) {
                  if (selectedDates.indexOf(event.date) == 0) {
                    return _buildCircle(event.date.day, selectedColor);
                  } else {
                    return _buildCircle(event.date.day, bookedColor);
                  }
                },
                todayBorderColor: Colors.transparent,
                todayButtonColor: Colors.transparent,
                selectedDayButtonColor: const Color(0xff615E83),
                selectedDayTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff9291A5),
                ),
                weekdayTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff9291A5),
                ),
                thisMonthDayBorderColor: Colors.transparent,
                daysHaveCircularBorder: false,
                weekFormat: false,
                height: height,
              ),
          ],
        );
      },
    );
  }

  Widget _buildCircle(int day, Color color) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text('$day', style: const TextStyle(color: Color(0xff1D1C2B))),
      ),
    );
  }
}
