import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/cupertino.dart';
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
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(34),
          color: Color(0xffFBF7EB),
        ),
        child: Text(
          label,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }
}
