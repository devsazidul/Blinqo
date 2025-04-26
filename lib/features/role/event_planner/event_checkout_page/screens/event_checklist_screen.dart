import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/create_checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart'
    show SpProfileController;
import '../../event_home_page/widgets/checklist_add_tack_button.dart';

class EventChecklistScreen extends StatelessWidget {
  const EventChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChecklistController controller = Get.put(ChecklistController());
    final spProfileController = Get.find<SpProfileController>();

    double screenHeight =
        MediaQuery.of(context).size.height; // Get screen height
    return Obx(() {
      final themeMode =
          spProfileController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.borderColor2,
        appBar: _buildAppBar(themeMode),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (controller.checklistItems.isNotEmpty) ...[
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          autofocus: true,
                          dropdownColor: AppColors.backgroundColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.buttonColor2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          value:
                              controller.filterType.value, // Bind to filterType
                          items:
                              ['ALL Task', 'Urgent!', 'Completed']
                                  .map(
                                    (label) => DropdownMenuItem(
                                      value: label,
                                      child: Text(
                                        label,
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.filterType.value =
                                  value; // Update filter type
                            }
                          },
                        ),
                      ),

                      const SizedBox(width: 16), // Space between dropdowns

                      Expanded(
                        child: DropdownButtonFormField<String>(
                          autofocus: true,
                          dropdownColor: AppColors.backgroundColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.buttonColor2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          value: controller.sortType.value, // Bind to sortType
                          items:
                              ['By Date', 'By Venue']
                                  .map(
                                    (label) => DropdownMenuItem(
                                      value: label,
                                      child: Text(
                                        label,
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.sortType.value = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                controller.filteredChecklistItems.isEmpty
                    ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImagePath.nochecklist),
                            const SizedBox(height: 20),
                            Text(
                              'Noting Found',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "You didn't added any task yes",
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff767676),
                              ),
                            ),
                            const SizedBox(height: 40),

                            OutlinedButton(
                              onPressed: () {
                                Get.to(const CreateChecklistScreen());
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 9,
                                  horizontal: 12,
                                ),
                                fixedSize: const Size(125, 44),
                                side: BorderSide(
                                  color: AppColors.iconColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Add Task',
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.iconColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    Icons.add_circle_outline_outlined,
                                    size: 24,
                                    color: AppColors.iconColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                              itemCount: 20, // Number of items in the list
                              itemBuilder: (context, index) {
                                double screenWidth =
                                    MediaQuery.of(
                                      context,
                                    ).size.width; // Get screen width

                                // Adjust font size based on screen size
                                double titleFontSize =
                                    screenWidth > 600
                                        ? 18
                                        : 16; // Larger font for larger screens
                                double subTitleFontSize =
                                    screenWidth > 600
                                        ? 14
                                        : 12; // Larger font for larger screens

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    height:
                                        screenHeight *
                                        0.11, // Height based on screen size
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color:
                                          AppColors
                                              .backgroundColor, // Container color
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween, // Space out children
                                      children: [
                                        Row(
                                          children: [
                                            Obx(() {
                                              return Align(
                                                alignment: Alignment.topLeft,
                                                child: Checkbox(
                                                  side: BorderSide(
                                                    color:
                                                        AppColors.buttonColor2,
                                                  ),
                                                  value:
                                                      controller
                                                          .selectedIndex
                                                          .value ==
                                                      index, // Check if the current index is selected
                                                  onChanged: (bool? value) {
                                                    if (value != null) {
                                                      controller.toggleCheckbox(
                                                        index,
                                                        value,
                                                      ); // Update the selected index
                                                    }
                                                  },
                                                ),
                                              );
                                            }),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 6.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Venue booking',
                                                    style: getTextStyle(
                                                      fontSize:
                                                          titleFontSize, // Adjusted font size
                                                      color:
                                                          AppColors
                                                              .buttonColor2,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    'The Grand Hall',
                                                    style: getTextStyle(
                                                      fontSize:
                                                          subTitleFontSize, // Adjusted font size
                                                      color:
                                                          AppColors
                                                              .subTitleColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    '20 Mar 2025',
                                                    style: getTextStyle(
                                                      fontSize:
                                                          subTitleFontSize, // Adjusted font size
                                                      color:
                                                          AppColors
                                                              .subTitleColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          ChecklistAddTackButton(screenHeight: screenHeight),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
              ],
            ),
          );
        }),
      );
    });
  }

  AppBar _buildAppBar(ThemeMode themeMode) {
    final ChecklistController controller = Get.find<ChecklistController>();

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      // leading: Padding(
      //   padding: EdgeInsets.only(left: 20.0),
      //   child: GestureDetector(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: CircleAvatar(
      //       backgroundColor:
      //           themeMode == ThemeMode.dark
      //               ? Color(0xffFFFFFF1A).withValues(alpha: 0.15)
      //               : Color(0xff000000).withValues(alpha: 0.15),
      //       child: Image.asset(
      //         IconPath.arrowLeftAlt,
      //         width: 16,
      //         color: AppColors.appBarArrowIconColor,
      //       ),
      //     ),
      //   ),
      // ),
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
        PopupMenuButton<String>(
          color: AppColors.primary,
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
                        color: AppColors.dopdownTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'Mark As Completed',
                  child: Center(
                    child: Text(
                      'Mark As Completed',
                      style: getTextStyle(
                        color: AppColors.dopdownTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'Mark As Urgent',
                  child: Center(
                    child: Text(
                      'Mark As Urgent',
                      style: getTextStyle(
                        color: AppColors.dopdownTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'Edit',
                  child: Center(
                    child: Text(
                      'Edit',
                      style: getTextStyle(
                        color: AppColors.dopdownTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
          icon: const Icon(Icons.more_vert, color: Colors.black),
        ),
      ],
      title: Text(
        'Checklist',
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
