import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_payment_controller/ep_payment_option_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCustomPaymentCard extends StatelessWidget {
  EpCustomPaymentCard({
    super.key,
    required this.epPaymentOptionController,
    required this.cardName,
    required this.cardImagePath,
    required this.cardIndex,
  });

  final EpPaymentOptionController epPaymentOptionController;
  final String cardName;
  final String cardImagePath;
  final int cardIndex;
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = controller.isDarkMode.value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.textFrieldDarkColor : AppColors.primary,
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
              color: isDarkMode ? AppColors.primary : AppColors.textColor,
            ),
          ),
          Spacer(),
          Obx(() {
            return GestureDetector(
              onTap: () {
                epPaymentOptionController.toggleCardSelection(cardIndex);
              },
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : AppColors.subTextColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color:
                      epPaymentOptionController.selectedCards[cardIndex]
                          ? Colors.transparent
                          : isDarkMode
                          ? Colors.transparent
                          : Colors.white,
                ),
                child:
                    epPaymentOptionController.selectedCards[cardIndex]
                        ? Image.asset(
                          IconPath.spcheckboxcard,
                          width: 25,
                          height: 25,
                          color:
                              isDarkMode
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
  }
}
