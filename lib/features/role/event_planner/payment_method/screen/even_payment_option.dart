import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/event_payment_controller.dart'; // Adjust the import path
import '../services/event_strip_service.dart';
import '../widget/event_payment_card.dart';

class EvenPaymentOption extends StatelessWidget {
  const EvenPaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    final PickColorController pickColorController = Get.find();
    bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    Get.put(EventPaymentController()); // Initialize the controller

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackgroundColor : Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: ThemeStyle.circleAvatarColor(isDarkMode),
              child: Image.asset(
                IconPath.arrowLeftAlt,
                width: 16,
                height: 12,
                color: ThemeStyle.whiteBlackColor(isDarkMode),
              ),
            ),
          ),
        ),
        title: Text(
          'Payment Option',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ThemeStyle.whiteBlackColor(isDarkMode),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              EventPaymentCard(
                imagePath: IconPath.mastercard,
                cardName: 'MasterCard',
                isDarkMode: isDarkMode,
                index: 0, // Pass index
              ),
              EventPaymentCard(
                imagePath: IconPath.debitcard,
                cardName: 'Debit Card',
                isDarkMode: isDarkMode,
                index: 1,
              ),
              EventPaymentCard(
                imagePath: IconPath.cardvisa,
                cardName: 'Visa',
                isDarkMode: isDarkMode,
                index: 2,
              ),
              EventPaymentCard(
                imagePath: IconPath.paypalcard,
                cardName: 'PayPal',
                isDarkMode: isDarkMode,
                index: 3,
              ),
              EventPaymentCard(
                imagePath: IconPath.klarna,
                cardName: 'Klarna',
                isDarkMode: isDarkMode,
                index: 4,
              ),
              SizedBox(height: 36),
              GestureDetector(
                onTap: () {
                  EventStripService.instance.makePayment(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color:
                        isDarkMode && !pickColorController.isFemale.value
                            ? Color(0xff003366)
                            : pickColorController.selectedColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: ThemeStyle.darkLight1(isDarkMode),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm & Pay',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
