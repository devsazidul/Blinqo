import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/profile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/event_payment_controller.dart';

class EventPaymentCard extends StatelessWidget {
  const EventPaymentCard({
    super.key,
    required this.imagePath,
    required this.cardName,
    required this.isDarkMode,
  });

  final String imagePath;
  final String cardName;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    // required controller
    final EventPaymentController controller = Get.put(EventPaymentController());
    return Container(
      width: double.infinity,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ThemeStyle.darkGreyWhite(isDarkMode),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ThemeStyle.darkGreyWhite(isDarkMode),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 24),
          SizedBox(width: 14),
          Text(
            cardName,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ThemeStyle.text1(isDarkMode),
            ),
          ),
          Spacer(),
          // checkbox
          Obx(
            () => Checkbox(
              value: controller.isSelected.value,
              onChanged: (_) {
                controller.toggleSelection();
              },
              activeColor: ThemeStyle.goldToBlack(isDarkMode),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: ThemeStyle.goldToBlack(isDarkMode),
                width: 1,
              ),
              checkColor: ThemeStyle.darkGreyWhite(isDarkMode),
              //  Color(0xffF9FAFB),
            ),
          ),
        ],
      ),
    );
  }
}
