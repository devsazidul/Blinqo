import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/controllers/payment_option_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VPaymentCard extends StatelessWidget {
  final String imagePath;
  final String cardName;

  // required controller
  final PaymentOptionController controller = Get.put(PaymentOptionController());

  VPaymentCard({super.key, required this.imagePath, required this.cardName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xffFEFEFE),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xffEBEBEB), width: 1),
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
              color: Color(0xff171725),
            ),
          ),
          Spacer(),
          // checkbox
          Obx(
            () => Checkbox(
              value: controller.isSelected.value,
              onChanged: (_) {
                controller.toggleSelection();
              },
              activeColor: Color(0xff003366),
              focusColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
