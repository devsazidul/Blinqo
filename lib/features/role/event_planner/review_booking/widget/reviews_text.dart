import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsText extends StatelessWidget {
  final String label;
  final String value;
  final bool? isColorChinge;

  final ThemeMode themeMode;
  const ReviewsText({
    super.key,
    required this.label,
    required this.value,
    required this.themeMode,
    this.isColorChinge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStylePoppins(
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.subTextColor,
          ),
        ),
        Text(
          value,
          style: getTextStylePoppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.buttonColor
                    : isColorChinge == true
                    ? AppColors.buttonColor2
                    : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
