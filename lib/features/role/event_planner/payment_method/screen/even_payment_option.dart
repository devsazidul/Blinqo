import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/event_strip_service.dart';
import '../widget/event_payment_card.dart';

class EvenPaymentOption extends StatelessWidget {
  const EvenPaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
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
            spacing: 12,
            children: [
              SizedBox(height: 40),
              EventPaymentCard(
                imagePath: IconPath.mastercard,
                cardName: 'MasterCard',
                isDarkMode: isDarkMode,
              ),
              EventPaymentCard(
                imagePath: IconPath.debitcard,
                cardName: 'Debit Card',
                isDarkMode: isDarkMode,
              ),
              EventPaymentCard(
                imagePath: IconPath.cardvisa,
                cardName: 'Visa',
                isDarkMode: isDarkMode,
              ),
              EventPaymentCard(
                imagePath: IconPath.paypalcard,
                cardName: 'PayPal',
                isDarkMode: isDarkMode,
              ),
              EventPaymentCard(
                imagePath: IconPath.klarna,
                cardName: 'Klarna',
                isDarkMode: isDarkMode,
              ),
              SizedBox(height: 36),

              // This is the button to add a new payment method
              GestureDetector(
                onTap: () {
                  EventStripService.instance.makePayment();
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
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

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
