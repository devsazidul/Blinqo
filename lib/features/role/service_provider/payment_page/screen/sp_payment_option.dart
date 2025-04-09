import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class SpPaymentOption extends StatelessWidget {
  const SpPaymentOption({super.key});

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
            Image.asset(
              IconPath.paymentempty,
              width: double.infinity,
              height: 195,
            ),
            SizedBox(height: 20),
            Text(
              "No Payment Method Found!",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
                lineHeight: 2,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "You can add or edit payment during checkout",
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
                lineHeight: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                debugPrint('Add a new payment method tapped');
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
