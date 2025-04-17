import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class StartBookingShearshBar extends StatelessWidget {
  const StartBookingShearshBar({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.03),

        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search venues & services...',
                  hintStyle: getTextStyle(
                    color: AppColors.subTextColor2,
                    fontSize: 14,
                  ),
                  filled: true,
                  suffixIcon: Icon(
                    Icons.mic_none,
                    color: AppColors.buttonColor2,
                  ),
                  fillColor: AppColors.primary,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),

            GestureDetector(
              onTap: () {},
              child: Container(
                height: screenHeight * 0.08,
                width: screenHeight * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.iconBackground,
                ),
                child: Icon(
                  Icons.tune,
                  color: AppColors.primary,
                ), // Icon for the filter button
              ),
            ),
          ],
        ),
      ],
    );
  }
}
