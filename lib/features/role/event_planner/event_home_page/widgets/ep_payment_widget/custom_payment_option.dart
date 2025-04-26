import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/payment_page/controller/sp_payment_option_controller.dart';
import 'package:flutter/material.dart';

class CustomPaymentOptions extends StatelessWidget {
  const CustomPaymentOptions({
    super.key,
    required this.spPaymentOptionController,
    required this.onTap,
    required this.iconPath,
    required this.label,
  });

  final SpPaymentOptionController spPaymentOptionController;
  final VoidCallback onTap;
  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: Image.asset(iconPath),
            ),
            SizedBox(width: 14),
            Text(
              label,
              style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
