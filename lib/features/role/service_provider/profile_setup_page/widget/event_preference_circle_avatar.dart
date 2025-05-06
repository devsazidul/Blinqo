import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/model/event_preference_model.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpEventPreferenceCircleAvatar extends StatelessWidget {
  final EventPreferenceModel eventPreference;

  const SpEventPreferenceCircleAvatar({
    super.key,
    required this.eventPreference,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpProfileController());
    final profileSetupController = Get.put(SpProfileSetupController());
    final themeMode =
        controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    final isSelected = profileSetupController.selectedEvents.contains(
      eventPreference.id,
    );
    // return Obx(() {
    return GestureDetector(
      onTap: () {
        profileSetupController.toggleEventSelection(eventPreference.id);
      },
      child: SizedBox(
        width: 110,
        height: 132,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    eventPreference.avatar.path,
                    width: 108,
                    height: 108,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: -5,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        IconPath.selected,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              eventPreference.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.textColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
    // });
  }
}
