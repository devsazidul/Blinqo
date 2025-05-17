import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartBookingDecorationCard extends StatelessWidget {
  const StartBookingDecorationCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.dropdownItems,
    required this.text2,
    required this.themeMode,
    this.onTap,
    this.pickColorController,
    required this.controller,
  });

  final double screenHeight;
  final double screenWidth;
  final void Function()? onTap;
  final List<String> dropdownItems;
  final String text2;
  final PickColorController? pickColorController;
  final TextEditingController controller;

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
                    : pickColorController?.isFemale.value ?? false
                    ? pickColorController?.selectedColor ??
                        AppColors.buttonColor2
                    : AppColors.buttonColor2,
          ),
        ),

        // dropdown menu
        Container(
          width: 200,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Color(0xFFFBF7EB),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: AppColors.secondary, width: 1),
          ),

          child: DropdownMenu(
            width: double.infinity,
            onSelected: (value) {
              debugPrint(value);
            },
            trailingIcon: Image.asset(
              IconPath.arrowdown,
              color: AppColors.secondary,
              height: 24,
            ),
            selectedTrailingIcon: RotatedBox(
              quarterTurns: 90,
              child: Image.asset(
                IconPath.arrowdown,
                color: AppColors.secondary,
                height: 24,
              ),
            ),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            ),

            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondary, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.secondary,
                  width: 1,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondary, width: 1),
              ),
            ),

            textStyle: getTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.secondary,
            ),

            initialSelection: dropdownItems.first,
            controller: controller,
            requestFocusOnTap: true,
            dropdownMenuEntries:
                dropdownItems.map((e) {
                  return DropdownMenuEntry(value: e, label: e);
                }).toList(),
          ),
        ),
        // GestureDetector(
        //   onTap: onTap,
        //   child: Container(
        //     width: 137.w,
        //     height: 36.h,
        //     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //       color: Color(0xffFBF7EB),
        //       border: Border.all(color: AppColors.buttonColor),
        //       borderRadius: BorderRadius.circular(4.0),
        //     ),
        //     child: Center(
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Short by",
        //             style: getTextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.w400,
        //               color: Color(0xffD4AF37),
        //             ),
        //           ),
        //           Spacer(),
        //           Image.asset(
        //             IconPath.backButton,
        //             width: 23.w,
        //             height: 23.h,
        //             color: AppColors.buttonColor,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
