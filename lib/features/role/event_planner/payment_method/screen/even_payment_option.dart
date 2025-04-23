import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/event_strip_service.dart';
import '../widget/event_payment_card.dart';

class EvenPaymentOption extends StatelessWidget {
  const EvenPaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: const Color(0xFFD9D9D9),
              child: Image.asset(
                IconPath.arrowLeftAlt,
                width: 16,
                height: 12,
                color: AppColors.textColor,
              ),
            ),
          ),
        ),

        title: Text(
          'Payment Option',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
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
              ),
              EventPaymentCard(
                imagePath: IconPath.debitcard,
                cardName: 'Debit Card',
              ),
              EventPaymentCard(imagePath: IconPath.cardvisa, cardName: 'Visa'),
              EventPaymentCard(
                imagePath: IconPath.paypalcard,
                cardName: 'PayPal',
              ),
              EventPaymentCard(imagePath: IconPath.klarna, cardName: 'Klarna'),
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
                    border: Border.all(color: Color(0xffE4E4E7), width: 1),
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
