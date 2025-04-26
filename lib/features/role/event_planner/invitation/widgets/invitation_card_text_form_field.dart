import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class InvitationCardTextFormField extends StatelessWidget {
  const InvitationCardTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLines,
  });

  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff868686),
          lineHeight: 1.6,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Color(0xffABB7C2), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Color(0xffABB7C2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Color(0xffABB7C2), width: 1),
        ),
      ),
    );
  }
}
