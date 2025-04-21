import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/common/styles/global_text_style.dart';
import '../controllers/even_profile_controller.dart';

class EventAvaterCard extends StatelessWidget {
  final EvenProfileController evenProfileController;
  final ThemeMode themeMode;
  final int index;
  const EventAvaterCard({
    super.key,
    required this.evenProfileController,
    required this.index,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => evenProfileController.toggleSelection(index),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      evenProfileController.eventPreferences[index]['image']!,
                    ),
                  ),
                  shape: BoxShape.circle,
                  color: Colors.grey.shade50, // Fixed: Non-nullable
                ),
              ),
              const SizedBox(height: 8),
              Text(
                evenProfileController.eventPreferences[index]['name']!,
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : Colors.black,
                ),
              ),
            ],
          ),

          // Check if 'verifyProfile' is "true" (string comparison)
          evenProfileController.eventPreferences[index]['verifyProfile'] ==
                  "true"
              ? Positioned(
                left: 65,
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(IconPath.selected),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
