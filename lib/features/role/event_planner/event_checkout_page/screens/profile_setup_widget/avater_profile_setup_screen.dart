import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/even_profile_controller.dart';

class AvaterProfileSetupScreen extends StatelessWidget {
  AvaterProfileSetupScreen({super.key, required this.themeMode});
  final evenProfileController = Get.find<EvenProfileController>();
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile Setup",
              style: getTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.borderColor2
                        : AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Obx(() {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child:
                      evenProfileController.profileImage.value == null
                          ? Image.asset(
                            IconPath.profile01,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                          : Image.file(
                            evenProfileController.profileImage.value!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    evenProfileController.pickImage();
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      IconPath.profileedit,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
