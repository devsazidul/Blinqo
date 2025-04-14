import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class VenueBookingPage extends StatelessWidget {
  const VenueBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Booking',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Booking List',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonColor2,
                  ),
                ),
                Spacer(),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(4),
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
                              color: Color(0xFFABB7C2),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFABB7C2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Image.asset(
              ImagePath.nocontentbackground,
              width: screenWidth * 0.6,
            ),
            SizedBox(height: 32),
            Text(
              'It looks like no events have been\n scheduled yet.',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
