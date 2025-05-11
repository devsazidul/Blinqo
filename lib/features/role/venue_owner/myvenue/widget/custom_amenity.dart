import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import 'package:get/get.dart';


class CustomAmenityBox extends StatelessWidget {
  final IconData icon;
  final String label;



  const CustomAmenityBox({
    super.key,
    required this.icon,
    required this.label,


  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Container(
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
        color: Color(0xffFBF7EB) ,
      ),
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff333333),
        ),
      ),
    );
  }
}
