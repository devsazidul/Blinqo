import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart' show IconPath;
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_payment_option_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_thanks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SpPaymentOptionCard extends StatelessWidget {
  SpPaymentOptionCard({super.key});

  final SpPaymentOptionController spPaymentOptionController = Get.put(
    SpPaymentOptionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFD9D9D9),
            child: Image.asset(IconPath.arrowLeftAlt),
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(IconPath.mastercard, width: 40, height: 24),
                        SizedBox(width: 14),
                        Text(
                          'Master Card',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(IconPath.cardvisa, width: 40, height: 24),
                        SizedBox(width: 14),
                        Text(
                          'Visa Card',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(IconPath.paymentaddcircle),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Add a new payment method',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            CustomContinueButton(
              onTap: () {
                Get.to(SpVerificationThanks());
              },
              title: "Confirm & Pay",
            ),
          ],
        ),
      ),
    );
  }
}
