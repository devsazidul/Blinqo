import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewsText extends StatelessWidget {
  final String label;
  final String value;
  final bool isColorChinge;

  final ThemeMode themeMode;
  const ReviewsText({
    super.key,
    required this.label,
    required this.value,
    required this.themeMode,
    this.isColorChinge = false,
  });

  @override
  Widget build(BuildContext context) {
    final PickColorController pickColorController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStylePoppins(
            color:
                themeMode == ThemeMode.dark
                    ? Color(0xffC0C0C0)
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
                    ? (isColorChinge ? Color(0xffD4AF37) : Color(0xffebebeb))
                    : (!isColorChinge
                        ? Color(0xff333333)
                        : (pickColorController.isFemale.value
                            ? pickColorController.selectedColor
                            : Color(0xff003366))),
          ),
        ),
      ],
    );
  }
}
