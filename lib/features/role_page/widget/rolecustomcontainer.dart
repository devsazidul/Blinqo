import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role_page/controller/role_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleCustomContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final int index;
  const RoleCustomContainer({
    required this.imagePath,
    required this.title,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RoleController roleController = Get.find<RoleController>();
    return Obx(() {
      bool isSelected = roleController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () {
          roleController.selectedRole(index);
        },
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.buttonColor2 : Colors.transparent,
              width: 4,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(imagePath, width: 40, height: 40),
              SizedBox(width: 12),
              Text(
                title,
                style: getTextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
