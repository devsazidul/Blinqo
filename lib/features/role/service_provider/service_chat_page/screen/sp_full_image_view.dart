import 'dart:io';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullImageView extends StatelessWidget {
  final String imagePath;

  FullImageView({super.key, required this.imagePath});
  final darkcontroller = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          darkcontroller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary.withValues(alpha: 0.10)
                        : AppColors.textColor.withValues(alpha: 0.10),
                child: Image.asset(
                  IconPath.arrowleft,
                  width: 16,
                  height: 12,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Hero(
            tag: imagePath,
            child: Image.file(File(imagePath), fit: BoxFit.contain),
          ),
        ),
      );
    });
  }
}
