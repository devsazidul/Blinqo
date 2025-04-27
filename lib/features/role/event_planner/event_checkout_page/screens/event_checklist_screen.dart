import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/create_checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventChecklistScreen extends StatelessWidget {
  const EventChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print("hello");
    // final ChecklistController controller = Get.put(ChecklistController());
    final profileController = Get.find<ProfileController>();

    double screenHeight =
        MediaQuery.of(context).size.height; // Get screen height
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    Get.put(ChecklistController());

    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.borderColor2,
        appBar: _buildAppBar(themeMode),

        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.08),
              SvgPicture.asset(
                ImagePath.nochecklist,
                height: screenHeight * 0.3,
              ),
              SizedBox(height: screenHeight * 0.010),
              Text(
                'Noting Found!',
                style: getTextStyle(
                  fontSize: screenWidth > 600 ? 20 : 16,
                  fontWeight: FontWeight.w600,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : AppColors.textColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.010),
              Text(
                "You didn't added any task yet",
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : AppColors.subTextColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              OutlinedButton(
                onPressed: () {
                  Get.to(const CreateChecklistScreen());
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth > 600 ? 12 : 9,
                    horizontal: screenWidth > 600 ? 20 : 12,
                  ),
                  fixedSize: Size(screenWidth * 0.4, 44),
                  side: BorderSide(
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.buttonColor
                            : AppColors.iconColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Task',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.buttonColor
                                : AppColors.iconColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.add_circle_outline_outlined,
                      size: 24,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.iconColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  AppBar _buildAppBar(ThemeMode themeMode) {
    final ChecklistController controller = Get.find<ChecklistController>();

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor:
                themeMode == ThemeMode.dark
                    ? Color(0xFFD9D9D9).withAlpha(40)
                    : const Color(0xFFD9D9D9),
            child: Image.asset(
              IconPath.arrowLeftAlt,
              width: 16,
              height: 12,
              color:
                  themeMode == ThemeMode.dark
                      ? Colors.white
                      : AppColors.textColor,
            ),
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        if (controller.checklistItems.isNotEmpty) // Null condition
          PopupMenuButton<String>(
            color:
                themeMode == ThemeMode.dark
                    ? Colors.grey[800] // Contrasting background for dark mode
                    : AppColors.primary ??
                        Colors.blue, // Fallback for light mode
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
                              themeMode == ThemeMode.dark
                                  ? Colors
                                      .white // Visible in dark mode
                                  : AppColors.dopdownTextColor ?? Colors.black,
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
                              themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : AppColors.dopdownTextColor ?? Colors.black,
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
                              themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : AppColors.dopdownTextColor ?? Colors.black,
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
                              themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : AppColors.dopdownTextColor ?? Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
            icon: Icon(
              Icons.more_vert,
              color:
                  themeMode == ThemeMode.dark
                      ? Colors
                          .white // Visible in dark mode
                      : Colors.black, // Visible in light mode
              size: 24, // Larger icon for visibility
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
