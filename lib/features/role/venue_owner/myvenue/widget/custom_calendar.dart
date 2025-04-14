import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class CustomCalendar extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final double height;

  const CustomCalendar({
    super.key,
    required this.selectedDatesNotifier,
    this.height = 320,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DateTime>>(
      valueListenable: selectedDatesNotifier,
      builder: (context, selectedDates, _) {
        return CalendarCarousel(
          onDayPressed: (date, events) {
            if (selectedDates.isEmpty) {
              selectedDatesNotifier.value = [date];
            } else if (selectedDates.contains(date)) {
              selectedDatesNotifier.value =
                  selectedDates.where((d) => d != date).toList();
            } else {
              selectedDatesNotifier.value = List.from(selectedDates)..add(date);
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
              return _buildCircle(event.date.day, const Color(0xff19480B));
            } else {
              return _buildCircle(event.date.day, const Color(0xff0066CC));
            }
          },
          todayBorderColor: Colors.transparent,
          todayButtonColor: Colors.transparent,
          selectedDayButtonColor: const Color(0xff0066CC),
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
        );
      },
    );
  }

  Widget _buildCircle(int day, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$day',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
