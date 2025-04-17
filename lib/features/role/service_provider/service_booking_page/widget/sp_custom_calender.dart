import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';

class SpCustomCalender extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final double height;

  SpCustomCalender({
    super.key,
    required this.selectedDatesNotifier,
    this.height = 370,
  });
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return ValueListenableBuilder<List<DateTime>>(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, _) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor.withValues(alpha: 0.07),
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
                  return _buildCircle(
                    event.date.day,
                    themeMode == ThemeMode.dark
                        ? AppColors.darkCalendarColor2
                        : AppColors.buttonColor,
                  );
                } else {
                  return _buildCircle(
                    event.date.day,
                    themeMode == ThemeMode.dark
                        ? AppColors.darkCalendarColor
                        : AppColors.spcalendarColor,
                  );
                }
              },
              todayBorderColor: Colors.transparent,
              todayButtonColor: Colors.transparent,
              selectedDayButtonColor:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : Color(0xff0066CC),
              selectedDayTextStyle: getTextStyle(
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor,
              ),
              weekendTextStyle: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor,
              ),
              headerTextStyle: getTextStyle(
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.spcalendarColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              iconColor:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.spcalendarColor,
              weekdayTextStyle: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : Color(0xff9291A5),
              ),
              todayTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor,
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
    });
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
