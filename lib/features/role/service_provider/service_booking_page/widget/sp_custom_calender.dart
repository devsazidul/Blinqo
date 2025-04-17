import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class SpCustomCalender extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final double height;

  const SpCustomCalender({
    super.key,
    required this.selectedDatesNotifier,
    this.height = 370,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DateTime>>(
      valueListenable: selectedDatesNotifier,
      builder: (context, selectedDates, _) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.textColor.withValues(alpha: 0.07),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CalendarCarousel(
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
                return _buildCircle(event.date.day, AppColors.buttonColor);
              } else {
                return _buildCircle(event.date.day, AppColors.darkTextColor);
              }
            },
            todayBorderColor: Colors.transparent,
            todayButtonColor: Colors.transparent,
            selectedDayButtonColor: const Color(0xff0066CC),
            selectedDayTextStyle: getTextStyle(color: AppColors.textColor),
            weekendTextStyle: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
            headerTextStyle: getTextStyle(
              color: AppColors.spcalendarColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            iconColor: AppColors.spcalendarColor,
            weekdayTextStyle: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff9291A5),
            ),
            todayTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
            thisMonthDayBorderColor: Colors.transparent,
            daysHaveCircularBorder: false,
            weekFormat: false,
            height: height,
            isScrollable: true,
            showHeader: true,
            showOnlyCurrentMonthDate: false,
          ),
        );
      },
    );
  }

  Widget _buildCircle(int day, Color color) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text('$day', style: const TextStyle(color: AppColors.primary)),
      ),
    );
  }
}
