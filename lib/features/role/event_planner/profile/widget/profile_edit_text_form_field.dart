import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditTextFormField extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  ProfileEditTextFormField({
    super.key,
    this.label,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.validator,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Container(
      padding: EdgeInsets.only(top: 9.5, bottom: 2, left: 8, right: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff32383D) : AppColors.primary,
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isDarkMode ? Color(0xff32383D) : AppColors.borderColor2,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        validator: validator,
        style: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          labelText: label,
          contentPadding: EdgeInsets.zero,
          hintStyle: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
          labelStyle: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.hintTextColor : AppColors.textColor,
          ),
          filled: true,
          fillColor: isDarkMode ? Color(0xff32383D) : Colors.white,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }
}
