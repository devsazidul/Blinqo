import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart' show IconPath;
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpVenueDetailsCustomReviewsWidget extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());

  final String userName;
  final String userIcon;
  final String reviewDate;
  final String reviewText;
  final int rating;

  EpVenueDetailsCustomReviewsWidget({
    required this.userName,
    required this.userIcon,
    required this.reviewDate,
    required this.reviewText,
    required this.rating,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                userIcon,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8),
            Column(
              children: [
                Text(
                  userName,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColors.primary : AppColors.textColor,
                  ),
                ),
                SizedBox(height: 3),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(rating, (index) {
                    return Image.asset(
                      IconPath.ratingstart2,
                      width: 11,
                      height: 11,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
              ],
            ),
            Spacer(),
            Text(
              reviewDate,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.smallText : AppColors.subTextColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Align(
          alignment: Alignment.center,
          child: Text(
            reviewText,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode ? AppColors.hintTextColor : AppColors.subTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
