import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartBookingDecorationImage extends StatelessWidget {
  const StartBookingDecorationImage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decoration',
          style: getTextStyle(
            color: AppColors.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Image.asset(
          ImagePath.venueview,
          height: screenHeight * 0.25,
          width: screenWidth * 0.9,
          fit: BoxFit.cover,
        ),
        SizedBox(height: screenHeight * 0.06),
      ],
    );
  }
}
