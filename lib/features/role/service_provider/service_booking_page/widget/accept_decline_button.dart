import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class AcceptDeclineButton extends StatelessWidget {
  final String text;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final VoidCallback onTap;

  const AcceptDeclineButton({
    super.key,
    required this.text,
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
          child: Center(
            child: Text(
              text,
              style: getTextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
