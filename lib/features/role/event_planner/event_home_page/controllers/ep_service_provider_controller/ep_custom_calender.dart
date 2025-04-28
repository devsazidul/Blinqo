import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';

class EpCustomCalender extends StatelessWidget {
  final ValueNotifier<List<DateTime>> selectedDatesNotifier;
  final double height;

  EpCustomCalender({
    super.key,
    required this.selectedDatesNotifier,
    this.height = 370,
  });
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDarkMode = profileController.isDarkMode.value; // Move inside Obx
      return ValueListenableBuilder<List<DateTime>>(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, _) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    isDarkMode
                        ? AppColors.primary
                        : AppColors.textColor.withValues(
                          alpha: 0.07,
                        ), // fixed typo here too
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
                    isDarkMode
                        ? AppColors.darkCalendarColor2
                        : AppColors.buttonColor,
                  );
                } else {
                  return _buildCircle(
                    event.date.day,
                    isDarkMode
                        ? AppColors.darkCalendarColor
                        : AppColors.darkTextColor,
                  );
                }
              },
              todayBorderColor: Colors.transparent,
              todayButtonColor: Colors.transparent,
              selectedDayButtonColor:
                  isDarkMode ? AppColors.primary : const Color(0xff0066CC),
              selectedDayTextStyle: getTextStyle(
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
              weekendTextStyle: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
              headerTextStyle: getTextStyle(
                color:
                    isDarkMode ? AppColors.primary : AppColors.spcalendarColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              iconColor:
                  isDarkMode ? AppColors.primary : AppColors.spcalendarColor,
              weekdayTextStyle: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColors.primary : const Color(0xff9291A5),
              ),
              todayTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
              daysTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
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
