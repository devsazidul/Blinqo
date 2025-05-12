import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/controllers/payment_option_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VPaymentCard extends StatelessWidget {
  final String imagePath;
  final String cardName;

  const VPaymentCard({
    super.key,
    required this.imagePath,
    required this.cardName,
  });

  @override
  Widget build(BuildContext context) {
    final PaymentOptionController controller = Get.put(
      PaymentOptionController(),
    );

    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;

    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFEFEFE),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDarkMode ? const Color(0xff32383D) : const Color(0xffEBEBEB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 24),
          const SizedBox(width: 14),
          Text(
            cardName,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  isDarkMode
                      ? const Color(0xffEBEBEB)
                      : const Color(0xff171725),
            ),
          ),
          const Spacer(),
          // Checkbox
          Obx(
            () => Checkbox(
              value: controller.selections[cardName]?.value ?? false,
              onChanged: (_) {
                controller.toggleSelection(cardName);
              },
              activeColor:
                  isDarkMode
                      ? const Color(0xffD4AF37)
                      : const Color(0xff003366),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color:
                    isDarkMode
                        ? const Color(0xffD4AF37)
                        : const Color(0xff003366),
                width: 1,
              ),
              checkColor:
                  isDarkMode
                      ? const Color(0xff151515)
                      : const Color(0xffF9FAFB),
            ),
          ),
        ],
      ),
    );
  }
}
