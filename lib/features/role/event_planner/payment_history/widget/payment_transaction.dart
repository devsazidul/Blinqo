import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentTransactionCard extends StatelessWidget {
  final bool isDarkMode =
      Get.put(VenueOwnerProfileController()).isDarkMode.value;
  PaymentTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff32383D) : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(IconPath.cardimage),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cash-in',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
                ),
              ),
              Text(
                'From Visa Card',
                style: getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
                ),
              ),
              Text(
                'Transaction ID - 5621456325542',
                style: getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff848484),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$ 500',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
                ),
              ),
              Text(
                'Dec 15, 2022',
                style: getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff848484),
                ),
              ),
              Text(
                '10:00 AM',
                style: getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff848484),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
