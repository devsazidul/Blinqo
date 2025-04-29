import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants/icon_path.dart';
import '../../home/controller/booking_controller.dart';

class StarkBookingAdditionalServices extends StatelessWidget {
  final controller = Get.put(BookingController());

  StarkBookingAdditionalServices({super.key, required this.themeMode});

  final ThemeMode themeMode;

  void _showSelectedServiceDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.9; // 90% of screen width
    final dialogHeight = screenWidth * 0.7; // Responsive height based on width

    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                IconPath.cancel2,
                width: 24,
                height: 24,
                color: AppColors.buttonColor,
              ),
            ],
          ),
          backgroundColor:
              themeMode == ThemeMode.dark ? Color(0xFF151515) : Colors.white,
          content: SizedBox(
            width: dialogWidth,
            height: dialogHeight,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.5,
              ),
              itemCount: controller.availableServices.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (!controller.isServiceSelected(
                      controller.availableServices[index],
                    )) {
                      controller.addService(
                        controller.availableServices[index],
                      );
                      Get.back(); // Close the dialog
                    } else {
                      Get.snackbar(
                        "Service Already Selected",
                        "You have already selected this service.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          controller.serviceImages[index],
                          width: screenWidth * 0.06,
                          height: screenWidth * 0.06,
                          color: AppColors.buttonColor2,
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          controller.availableServices[index],
                          style: getTextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                            color: AppColors.buttonColor2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Additional Services',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.borderColor2
                      : Color(0xff333333),
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        Obx(() {
          return Wrap(
            spacing: 8.0,
            children:
                controller.selectedServices.map((service) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 6.0 : 8.0,
                      vertical: isSmallScreen ? 3.0 : 4.0,
                    ),
                    width: isSmallScreen ? screenWidth * 0.35 : 121.0,
                    height: isSmallScreen ? 36.0 : 50.0,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor3,
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.buttonColor
                                : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text(
                              service,
                              style: getTextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.buttonColor
                                        : AppColors.buttonColor2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.removeService(service);
                            },
                            child: Image.asset(
                              IconPath.cancelIcon2,
                              width: isSmallScreen ? 16 : 20,
                              height: isSmallScreen ? 16 : 20,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          );
        }),

        SizedBox(height: isSmallScreen ? 8 : 10),

        // Responsive "Add Service" button
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => _showSelectedServiceDialog(context),
            child: Container(
              width: screenWidth * 0.35,
              height: isSmallScreen ? 40.0 : 45.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    themeMode == ThemeMode.dark
                        ? Color(0x1AD4AF37)
                        : Colors.white,
                border: Border.all(
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.buttonColor
                          : AppColors.buttonColor2,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Service",
                    style: getTextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w400,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 6 : 8),
                  Image.asset(
                    IconPath.cancel,
                    width: isSmallScreen ? 18 : 20,
                    height: isSmallScreen ? 18 : 20,
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.buttonColor
                            : AppColors.buttonColor2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
