import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class EventStatusLabel extends StatelessWidget {
  final Color color;
  final String label;
  final ThemeMode themeMode;
  const EventStatusLabel({
    super.key,
    required this.color,
    required this.label,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,

            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
