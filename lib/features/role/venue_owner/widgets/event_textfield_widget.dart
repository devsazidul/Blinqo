import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final VenueOwnerProfileController profileController = Get.put(VenueOwnerProfileController());
    final bool isDarkMode = profileController.isDarkMode.value;

    return TextFormField(
      controller: controller,
      validator: validator,
      style: getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff767676),
        ),
        hintText: hintText,
        hintStyle: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
      ),
    );
  }
}
