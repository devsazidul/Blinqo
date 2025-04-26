import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/image_path.dart';

class EmtryBooking extends StatelessWidget {
  const EmtryBooking({
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
        SvgPicture.asset(ImagePath.nochecklist),
        SizedBox(height: screenHeight * 0.02),
        Column(
          children: [
            Text(
              'It Seems You Haven\'t Scheduled Any',
              style: getTextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color(0xffEBEBEB),
              ),
            ),
            SizedBox(height: screenHeight * 0.004),
            Text(
              "Events So Far.",
              style: getTextStyle(
                fontSize: screenWidth * 0.03, // 3% of screen width
                fontWeight: FontWeight.w400,
                color: const Color(0xffEBEBEB),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
