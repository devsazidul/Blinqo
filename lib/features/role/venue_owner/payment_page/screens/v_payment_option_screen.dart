import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';

import 'package:blinqo/features/role/venue_owner/payment_page/controllers/payment_option_controller.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/services/v_strip_service.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_card.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VPaymentOptionScreen extends StatelessWidget {
  const VPaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(VenueOwnerProfileController());
    final PaymentOptionController paymentController = Get.put(PaymentOptionController());

    // List of payment options
    const paymentOptions = [
      'MasterCard',
      'Debit Card',
      'Visa',
      'PayPal',
      'Klarna',
    ];

    // Initialize selection states for all payment options
    paymentController.initializeSelections(paymentOptions);

    final bool isDarkMode = Get.find<VenueOwnerProfileController>().isDarkMode.value;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xff151515) : const Color(0xffF4F4F4),
      appBar: const VPaymentAppBar(title: 'Payment Option'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const VPaymentCard(
                imagePath: IconPath.mastercard,
                cardName: 'MasterCard',
              ),
              const SizedBox(height: 12),
              const VPaymentCard(
                imagePath: IconPath.debitcard,
                cardName: 'Debit Card',
              ),
              const SizedBox(height: 12),
              const VPaymentCard(
                imagePath: IconPath.cardvisa,
                cardName: 'Visa',
              ),
              const SizedBox(height: 12),
              const VPaymentCard(
                imagePath: IconPath.paypalcard,
                cardName: 'PayPal',
              ),
              const SizedBox(height: 12),
              const VPaymentCard(
                imagePath: IconPath.klarna,
                cardName: 'Klarna',
              ),
              const SizedBox(height: 36),
              // Confirm Button
              GestureDetector(
                onTap: () {
                  VStripeServices.instance.makePayment();
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xff003366),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDarkMode ? const Color(0xff003366) : const Color(0xffE4E4E7),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}