import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';

class CustomCircleAvater extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;

  const CustomCircleAvater({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return GestureDetector(
      onTap: () {
        profileController.toggleEventSelection(text);
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primary,
                child: Image.asset(
                  imagePath,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 5,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      IconPath.selected,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
