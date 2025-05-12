import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NoBookingsView extends StatelessWidget {
  const NoBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Booking List',
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Color(0xffEBEBEB) : AppColors.buttonColor2,
              ),
            ),
            Spacer(),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color:
                    isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isDarkMode ? Color(0xffABB7C2) : Color(0xFFABB7C2),
                  width: 1,
                ),
              ),
              child: DropdownButton(
                underline: SizedBox.shrink(),
                items: [],
                onChanged: (value) {},
                icon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Short By',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xFFABB7C2),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xFFABB7C2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
        Image.asset(ImagePath.nocontentbackground, width: screenWidth * 0.6),
        SizedBox(height: 32),
        Text(
          'It looks like no events have been\n scheduled yet.',
          textAlign: TextAlign.center,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xFF333333),
          ),
        ),
        SizedBox(height: 40),
        // add booking button
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.buttonColor2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'Add Booking ',
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
