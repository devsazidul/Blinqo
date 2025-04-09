import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileEditTextFormField extends StatelessWidget {
  const ProfileEditTextFormField({
    super.key,
    required this.label,
    this.controller,
  });

  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        style: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
