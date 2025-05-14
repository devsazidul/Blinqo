import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class CustomShapeTag extends StatelessWidget {
  final String label;

  const CustomShapeTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color:isDarkMode ? Color(0xff32383D) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Text(
          label,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
        ),
      ),
    );
  }
}
