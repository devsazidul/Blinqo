import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSummarySection extends StatelessWidget {
  const ProfileSummarySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// name
        Text(
          'Ronald Richards',
          style: getTextStyle(
            fontSize: 20,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        
        /// City
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconPath.locationOn,
              height: 16,
              width: 16,
            ),
            SizedBox(width: 4),
            Text(
              'New York',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        
        /// Profession
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconPath.camera,
              height: 16,
              width: 16,
            ),
            SizedBox(width: 4),
            Text(
              'Photographer',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
