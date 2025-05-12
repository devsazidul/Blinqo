import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSummarySection extends StatelessWidget {
  const ProfileSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(SpProfileController()).isDarkMode.value;
    return Column(
      children: [
        /// name
        Text(
          SpAuthController.profileInfoModel?.name ?? "unknown",
          style: getTextStyle(
            fontSize: 20,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),

        /// City
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconPath.locationOn,
              height: 16,
              width: 16,
              color:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
            ),
            SizedBox(width: 4),
            Text(
              SpAuthController.profileInfoModel?.location ?? "unknown",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        /// Profession
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconPath.camera,
              height: 16,
              width: 16,
              color:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
            ),
            SizedBox(width: 4),
            Text(
              SpAuthController.profileInfoModel?.serviceProviderRole ??
                  "unknown",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
