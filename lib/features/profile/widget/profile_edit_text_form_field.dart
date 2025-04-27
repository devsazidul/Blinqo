import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditTextFormField extends StatelessWidget {
  const ProfileEditTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
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
        style: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          contentPadding: EdgeInsets.zero,

          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          filled: true,
          fillColor: isDarkMode ? Color(0xff32383D) : Colors.white,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
