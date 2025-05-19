import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/gif_path.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpCongratulationsPage extends StatelessWidget {
  SpCongratulationsPage({super.key});
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Congratulations',
            style: getTextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.appBarIcolor,
                child: IconButton(
                  onPressed: () {
                    Get.offAll(SpBottomNavBarScreen());
                  },
                  icon: Image.asset(IconPath.close, width: 15, height: 15),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  themeMode == ThemeMode.dark
                      ? GifPath.successdark
                      : GifPath.successlight,
                  width: double.infinity,
                  height: 270,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.textFieldDarkColor
                          : AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Youre Verified!",
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.textColor,
                          lineHeight: 2,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Your profile now includes a trust badge and will appear higher in searches.",
                        style: getTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.textColor,
                          lineHeight: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
