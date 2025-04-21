import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class StartBookingShearshBar extends StatelessWidget {
  const StartBookingShearshBar({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.themeMode,
    this.onChanged,
    this.onTap,
  });

  final double screenHeight;
  final double screenWidth;
  final ThemeMode themeMode;
  final void Function()? onTap;

  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.03),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                onTap: onTap,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Search venues & services...',
                  hintStyle: getTextStyle(
                    color:
                        themeMode == ThemeMode.dark
                            ? Color(0xffE6EBF0)
                            : AppColors.subTextColor2,
                    fontSize: 14,
                  ),
                  filled: true,
                  suffixIcon: Icon(
                    Icons.mic_none,
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.buttonColor
                            : AppColors.buttonColor2,
                  ),
                  fillColor:
                      themeMode == ThemeMode.dark
                          ? AppColors.iconBackground
                          : AppColors.primary,

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
