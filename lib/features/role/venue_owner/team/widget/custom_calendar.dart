import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final SpHomeController spHomeController = Get.find<SpHomeController>();

    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        spHomeController.updateSelectedDate(selectedDate);
      },
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        monthStyle: getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.buttonColor2, // Static color for now
        ),
        showSelectedDate: false,
        centerHeader: true,
      ),
      dayProps: EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        height: 58,
        width: 33,
        activeDayStyle: const DayStyle(
          borderRadius: 32.0,
          decoration: BoxDecoration(
            color: AppColors.buttonColor2,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        inactiveDayStyle: const DayStyle(borderRadius: 8),
        activeDayNumStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        inactiveDayNumStyle: getTextStyle(
          fontSize: 12,
          color: AppColors.textColor, // Static text color
          fontWeight: FontWeight.w500,
        ),
        activeDayStrStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        inactiveDayStrStyle: getTextStyle(
          fontSize: 12,
          color: AppColors.textColor, // Static text color
          fontWeight: FontWeight.w500,
        ),
      ),
      timeLineProps: const EasyTimeLineProps(
        hPadding: 20.0,
        separatorPadding: 20.0,
      ),
    );
  }
}
