import 'package:flutter/material.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isObscure;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xff767676),
          ),
          border: const OutlineInputBorder(), // optional: add border
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}
