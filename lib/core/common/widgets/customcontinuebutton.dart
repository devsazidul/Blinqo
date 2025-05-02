import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomContinueButton extends StatelessWidget {
  const CustomContinueButton({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.buttonColor2,
    this.borderColor = AppColors.buttonColor2,
    this.textStyle,
    required this.onPress,
    this.textColor = AppColors.backgroundColor,
  });
  final Color textColor;
  final String title;
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? backgroundColor),
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
          ),
          child: Center(
            child: Text(
              title,
              style: getTextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
