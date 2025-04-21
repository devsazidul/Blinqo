import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessageButtonSection extends StatelessWidget {
  const MessageButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x1A003366),
          borderRadius: BorderRadius.circular(12),
          border:isDarkMode? Border.all(
            width: 1,
            color: Color(0xff003366),
          ): null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(IconPath.messageicon, width: 24, height: 24,color: isDarkMode ? Color(0xffE6EBF0) : null,),
              SizedBox(width: 10),
              Text(
                'Message',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:isDarkMode ? Color(0xffE6EBF0) : Color(0xff003366),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
