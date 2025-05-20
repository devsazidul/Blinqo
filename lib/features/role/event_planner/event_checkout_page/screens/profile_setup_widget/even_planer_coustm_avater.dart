import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/controller/sp_profile_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EvenPlanerCoustmAvater extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;

  const EvenPlanerCoustmAvater({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double circleavatarradius = (screenHeight < 700) ? 50 : 58;
    final profileController = Get.find<SpProfileSetupController>();

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
                radius: circleavatarradius,
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
                  top: 0,
                  right: -5,
                  child: CircleAvatar(
                    radius: 24,
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
