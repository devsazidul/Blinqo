import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:get/get.dart';

class SpCustomChatList extends StatelessWidget {
  final String imagePath;
  final String name;
  final String lastMessage;
  final String time;

  SpCustomChatList({
    super.key,
    required this.imagePath,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
  final controller = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24,
          child: Image.asset(
            imagePath,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: getTextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.primary
                    : AppColors.textColor,
          ),
        ),
        subtitle: Text(
          lastMessage,
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.subTextColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: getTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.subTextColor,
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      );
    });
  }
}
