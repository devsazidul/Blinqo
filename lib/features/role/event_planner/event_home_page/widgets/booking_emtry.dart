import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingEmtry extends StatelessWidget {
  const BookingEmtry({
    super.key,
    required this.screenWidthFactor,
    required this.screenHeightFactor,
    required this.pickColorController,
  });

  final double screenWidthFactor;
  final double screenHeightFactor;
  final PickColorController pickColorController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;

    return Column(
      children: [
        SizedBox(height: 20 * screenHeightFactor),
        Row(
          children: [
            Text(
              'Booking List',
              style: getTextStyle(
                fontSize: 18 * screenWidthFactor,
                fontWeight: FontWeight.w600,
                // color: AppColors.buttonColor2,
                color:
                    isDarkMode
                        ? AppColors.borderColor2
                        : pickColorController.isFemale.value
                        ? pickColorController.selectedColor
                        : AppColors.buttonColor2,
              ),
            ),
            const Spacer(),
            Container(
              width: 93 * screenWidthFactor,
              height: 36 * screenHeightFactor,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      isDarkMode ? Color(0xffABB7C2) : AppColors.buttonColor2,
                ),
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
                        fontSize: 12 * screenWidthFactor,
                        fontWeight: FontWeight.w400,
                        color:
                            isDarkMode
                                ? Color(0xffABB7C2)
                                : AppColors.buttonColor2,
                      ),
                    ),
                    Image.asset(
                      IconPath.backButton,
                      width: 20 * screenWidthFactor,
                      height: 14 * screenHeightFactor,
                      color:
                          isDarkMode
                              ? Color(0xffABB7C2)
                              : AppColors.buttonColor2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 32 * screenHeightFactor),
        SvgPicture.asset(ImagePath.nochecklist),
        SizedBox(height: 10 * screenHeightFactor),
        Text(
          'It seems you haven\'t scheduled \nany events so far.',
          style: getTextStyle(
            fontSize: 14 * screenWidthFactor,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40 * screenHeightFactor),
        FCustomButton(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Booking',
                style: getTextStyle(
                  fontSize: 16 * screenWidthFactor,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 4 * screenWidthFactor),
              Icon(
                Icons.add,
                color: AppColors.primary,
                size: 20 * screenWidthFactor,
              ),
            ],
          ),

          onPressed: () {
            Navigator.pushNamed(context, AppRoute.startBooking);
          },
        ),

        // GestureDetector(
        //   onTap: () {
        //     Navigator.pushNamed(context, AppRoute.startBooking);
        //     // Get.to(() => const StartBooking());
        //   },
        //   child: Container(
        //     width: 353 * screenWidthFactor,
        //     height: 48 * screenHeightFactor,
        //     decoration: BoxDecoration(
        //       color: AppColors.buttonColor2,
        //       borderRadius: BorderRadius.circular(12.0),
        //     ),
        //     child: Center(
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             'Add Booking',
        //             style: getTextStyle(
        //               fontSize: 16 * screenWidthFactor,
        //               fontWeight: FontWeight.w600,
        //               color: AppColors.primary,
        //             ),
        //           ),
        //           SizedBox(width: 4 * screenWidthFactor),
        //           Icon(
        //             Icons.add,
        //             color: AppColors.primary,
        //             size: 20 * screenWidthFactor,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(height: 236 * screenHeightFactor),
      ],
    );
  }
}
