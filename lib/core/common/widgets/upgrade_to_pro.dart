import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class UpgradeToProcard extends StatelessWidget {
  final VoidCallback onTap;
  const UpgradeToProcard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF003285)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upgrade to pro',
              style: getTextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                lineHeight: 2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Boost Your Visibility & Get More Bookings with Premium!',
              style: getTextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                lineHeight: 1.5,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Get.to(SpPaymentOption());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Upgrade Now',
                  style: getTextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    lineHeight: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
