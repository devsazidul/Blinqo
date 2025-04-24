import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:get/get.dart';

class FacilityTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const FacilityTag({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff32383D) : Color(0xffFBF7EB),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withValues(alpha: .3),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Icon(icon, size: 14, color: const Color(0xffD4AF37)),
          const SizedBox(width: 8),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? Color(0xffEBEBEB) : const Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
