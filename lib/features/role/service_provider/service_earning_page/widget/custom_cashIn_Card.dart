// ignore_for_file: file_names

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCashInCard extends StatelessWidget {
  final String amount;
  final String transactionId;
  final String date;
  final String time;

  CustomCashInCard({
    super.key,
    required this.amount,
    required this.transactionId,
    required this.date,
    required this.time,
  });
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Card(
        elevation: 0,
        color:
            themeMode == ThemeMode.dark
                ? AppColors.textColor
                : AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.buttonColor
                          : AppColors.buttonColor2,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(IconPath.cardimage, width: 28, height: 28),
                ),
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cash - in",
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                  Text(
                    "From Visa Card",
                    style: getTextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                  Text(
                    "Transaction ID - $transactionId",
                    style: getTextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitleColor2,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    amount,
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                  Text(
                    date,
                    style: getTextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitleColor2,
                    ),
                  ),
                  Text(
                    time,
                    style: getTextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitleColor2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
