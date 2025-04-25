import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final SpHomeController spHomeController = Get.put(SpHomeController());

    // আজকের তারিখ বাদ দিয়ে প্রথম তারিখের জন্য একদিন আগে দিবে।
    final DateTime initialDate = DateTime.now().subtract(Duration(days: 1)); 

    return EasyDateTimeLine(
      initialDate: initialDate, // আজকের তারিখ নয়
      onDateChange: (selectedDate) {
        // যদি আজকের তারিখ সিলেক্ট করা হয়, তবে সেটি না নেয়া হবে
        if (selectedDate.day == DateTime.now().day &&
            selectedDate.month == DateTime.now().month &&
            selectedDate.year == DateTime.now().year) {
          return; // আজকের তারিখ নিষিদ্ধ
        }

        spHomeController.updateSelectedDate(selectedDate); // তারিখ আপডেট
      },
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        monthStyle: getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkMode
              ? Color(0xffD4AF37)  // ডার্ক মোডের জন্য
              : Color(0xff003366), // লাইট মোডের জন্য
        ),
        showSelectedDate: false,
        centerHeader: true,
      ),
      dayProps: EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        height: 58,
        width: 33,
        activeDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            color: isDarkMode ? Color(0xffEBEBEB) : AppColors.primary,
          ),
          borderRadius: 32.0,
          decoration: BoxDecoration(
            color: AppColors.buttonColor2,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColors.buttonColor2, width: 2),
          ),
        ),
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            color: isDarkMode ? Color(0xffEBEBEB) : AppColors.textColor,
          ),
          borderRadius: 8,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xff32383D) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                color: isDarkMode ? Color(0xff32383D) : AppColors.backgroundColor,
                width: 2),
          ),
        ),
        activeDayNumStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Color(0xffEBEBEB) : AppColors.primary,
        ),
        inactiveDayNumStyle: getTextStyle(
          fontSize: 12,
          color: isDarkMode ? Color(0xffEBEBEB) : AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
        activeDayStrStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        inactiveDayStrStyle: getTextStyle(
          fontSize: 12,
          color: isDarkMode ? Color(0xffEBEBEB) : AppColors.textColor,
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

