import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_payment_option_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpCustomPaymentCard extends StatelessWidget {
  SpCustomPaymentCard({
    super.key,
    required this.spPaymentOptionController,
    required this.cardName,
    required this.cardImagePath,
    required this.cardIndex,
  });

  final SpPaymentOptionController spPaymentOptionController;
  final String cardName;
  final String cardImagePath;
  final int cardIndex;
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color:
              themeMode == ThemeMode.dark
                  ? AppColors.textFrieldDarkColor
                  : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(cardImagePath, width: 40, height: 24),
            SizedBox(width: 14),
            Text(
              cardName,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor,
              ),
            ),
            Spacer(),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  spPaymentOptionController.toggleCardSelection(cardIndex);
                },
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.subTextColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        spPaymentOptionController.selectedCards[cardIndex]
                            ? Colors.transparent
                            : themeMode == ThemeMode.dark
                            ? Colors.transparent
                            : Colors.white,
                  ),
                  child:
                      spPaymentOptionController.selectedCards[cardIndex]
                          ? Image.asset(
                            IconPath.spcheckboxcard,
                            width: 25,
                            height: 25,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.buttonColor
                                    : AppColors.buttonColor2,
                          )
                          : Container(),
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
