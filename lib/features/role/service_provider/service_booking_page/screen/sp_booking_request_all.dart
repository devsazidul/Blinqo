import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/controller/sp_booking_controller.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/sp_project_request.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/sp_custom_booking_request.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpBookingRequestAll extends StatelessWidget {
  SpBookingRequestAll({super.key});
  final controller = Get.put(SpProfileController());
  final SpBookingController spBookingController = Get.put(
    SpBookingController(),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary.withValues(alpha: .10)
                        : AppColors.textColor.withValues(alpha: .10),
                child: Image.asset(
                  IconPath.arrowleft,
                  width: 16,
                  height: 12,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Booking Request ",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            itemCount: spBookingController.bookingRequests.length,
            itemBuilder: (context, index) {
              final booking = spBookingController.bookingRequests[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SpCustomBookingRequest(
                  title: booking['title']!,
                  location: booking['location']!,
                  date: booking['date']!,
                  time: booking['time']!,
                  logoPath: booking['uplogo']!,
                  onTap: () {
                    Get.to(SpProjectRequest());
                  },
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
