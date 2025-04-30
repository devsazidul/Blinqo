import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
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
    required this.index, // Add index to identify the card
  });

  final String imagePath;
  final String cardName;
  final bool isDarkMode;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PickColorController pickColorController = Get.find();
    // Get the controller (use Get.find since it's already initialized in the parent widget)
    final EventPaymentController controller = Get.put(EventPaymentController());

    return Container(
      width: double.infinity,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: EdgeInsets.only(bottom: 12),
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
          // Checkbox
          Obx(
            () => Checkbox(
              value:
                  controller.selectedIndex.value ==
                  index, // Check if this card is selected
              onChanged: (bool? value) {
                if (value == true) {
                  controller.selectPaymentOption(index); // Select this card
                }
              },
              activeColor:
                  isDarkMode && !pickColorController.isFemale.value
                      ? ThemeStyle.goldToBlack(isDarkMode)
                      : pickColorController.selectedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: ThemeStyle.goldToBlack(isDarkMode),
                width: 1,
              ),
              checkColor: ThemeStyle.darkGreyWhite(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }
}
