import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartBookingDecorationCard extends StatelessWidget {
  const StartBookingDecorationCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.text,
    required this.text2,
    required this.themeMode,

    this.onTap,
  });

  final double screenHeight;
  final double screenWidth;
  final void Function()? onTap;
  final String text;
  final String text2;

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text2,
          style: getTextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,

            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.buttonColor2,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 137.w,
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffFBF7EB),
              border: Border.all(color: AppColors.buttonColor),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Short by",
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    IconPath.backButton,
                    width: 23.w,
                    height: 23.h,
                    color: AppColors.buttonColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
