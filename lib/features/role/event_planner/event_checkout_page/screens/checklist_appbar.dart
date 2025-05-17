import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChecklistAppbar extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  final ChecklistController controller = Get.find<ChecklistController>();
  final ThemeMode themeMode;

  ChecklistAppbar({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor:
                isDarkMode
                    ? Color(0xFFD9D9D9).withAlpha(40)
                    : const Color(0xFFD9D9D9),
            child: Image.asset(
              IconPath.arrowLeftAlt,
              width: 16,
              height: 12,
              color: isDarkMode ? Colors.white : AppColors.textColor,
            ),
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        if (controller.checklistItems.isNotEmpty)
          PopupMenuButton<String>(
            color: isDarkMode ? Colors.grey[800] : AppColors.primary,
            onSelected: (value) {
              if (value == 'Delete') {
                controller.checklistItems.clear();
                controller.updateFilteredList();
              } else if (value == 'Mark As Completed') {
                for (var item in controller.checklistItems) {
                  item.isCompleted = true;
                }
                controller.checklistItems.refresh();
                controller.updateFilteredList();
              } else if (value == 'Mark As Urgent') {
                for (var item in controller.checklistItems) {
                  item.isUrgent = true;
                }
                controller.checklistItems.refresh();
                controller.updateFilteredList();
              } else if (value == 'Edit') {
                if (controller.checklistItems.isNotEmpty) {
                  controller.editItem(0);
                }
              }
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Delete',
                    child: Center(
                      child: Text(
                        'Delete',
                        style: getTextStyle(
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : AppColors.dopdownTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'Mark As Completed',
                    child: Center(
                      child: Text(
                        'Mark As Completed',
                        style: getTextStyle(
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : AppColors.dopdownTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'Mark As Urgent',
                    child: Center(
                      child: Text(
                        'Mark As Urgent',
                        style: getTextStyle(
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : AppColors.dopdownTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: Center(
                      child: Text(
                        'Edit',
                        style: getTextStyle(
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : AppColors.dopdownTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 24,
            ),
          ),
      ],
      title: Text(
        'Checklist',
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color:
              themeMode == ThemeMode.dark ? Colors.white : AppColors.textColor,
        ),
      ),
    );
  }
}
