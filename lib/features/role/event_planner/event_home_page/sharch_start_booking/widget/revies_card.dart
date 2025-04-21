import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviesCard extends StatelessWidget {
  const ReviesCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive adjustments
    final screenWidth = MediaQuery.of(context).size.width;

    // Define scaling factors based on screen width
    final titleFontSize = screenWidth < 400 ? 20.0 : 24.0;
    final priceFontSize = screenWidth < 400 ? 14.0 : 16.0;
    final ratingFontSize = screenWidth < 400 ? 12.0 : 14.0;
    final reviewsFontSize = screenWidth < 400 ? 10.0 : 12.0;
    final locationFontSize = screenWidth < 400 ? 12.0 : 14.0;

    // Adjust padding based on screen size
    final horizontalPadding = screenWidth < 400 ? 10.0 : 14.0;
    final verticalPadding = screenWidth < 400 ? 8.0 : 10.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "The Grand Hall",
                style: getTextStyle(
                  fontSize: titleFontSize.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              decoration: BoxDecoration(
                color: Color(0x1A003366),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "\$ Set Price",
                style: getTextStyle(
                  fontSize: priceFontSize.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.buttonColor2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0.h), // Use .h for responsive height
        Row(
          children: [
            Icon(
              Icons.star,
              size: 18.sp, // Make icon size responsive
              color: AppColors.reviesStarColor,
            ),
            Text(
              "5.0 ",
              style: getTextStyle(
                color: Colors.black,
                fontSize: ratingFontSize.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "(345 reviews)",
              style: getTextStyle(
                color: AppColors.subTextColor2,
                fontSize: reviewsFontSize.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0.h),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.buttonColor2,
              size: 14.sp, // Make icon size responsive
            ),
            SizedBox(width: 8.0.w), // Use .w for responsive width
            Flexible(
              child: Text(
                "New York",
                style: getTextStyle(
                  fontSize: locationFontSize.sp,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
