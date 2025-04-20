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
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final PaymentOptionController controller = PaymentOptionController();
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xffF4F4F4),
      appBar: VPaymentAppBar(title: 'Payment Option'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              SizedBox(height: 40),
              VPaymentCard(
                imagePath: IconPath.mastercard,
                cardName: 'MasterCard',
              ),
              VPaymentCard(imagePath: IconPath.debitcard, cardName: 'Debit Card'),
              VPaymentCard(imagePath: IconPath.cardvisa, cardName: 'Visa'),
              VPaymentCard(imagePath: IconPath.paypalcard, cardName: 'PayPal'),
              VPaymentCard(imagePath: IconPath.klarna, cardName: 'Klarna'),
              SizedBox(height: 36),
          
              // This is the button to add a new payment method
              GestureDetector(
                onTap: () {
                  VStripeServices.instance.makePayment();
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xff003366),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDarkMode ? Color(0xff003366) : Color(0xffE4E4E7),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
