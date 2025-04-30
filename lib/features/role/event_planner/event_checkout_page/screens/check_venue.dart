import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/checklist_appbar.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/widgets/ep_custom_check_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_checklist_screen.dart';

class CheckVenue extends StatelessWidget {
  final String eventName;
  final String taskName;
  final String selectedDate;
  final String selectedTime;

  const CheckVenue({
    super.key,
    required this.eventName,
    required this.taskName,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    final checklistController = Get.find<ChecklistController>();
    final profileController = Get.find<ProfileController>();
    final femaleColorController = Get.put(PickColorController());
    final bool isFemale = femaleColorController.isFemale.value;
    final themeMode =
        profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    Rx<String> dropdownValue = 'All Task'.obs;
    Rx<String> dropdown = 'By Date'.obs;
    return Scaffold(
      backgroundColor:
          themeMode == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: ChecklistAppbar(themeMode: themeMode),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 36,
                    width: 150,
                    decoration: BoxDecoration(
                      color:
                          themeMode == ThemeMode.dark
                              ? Color(0xff32383D)
                              : isFemale
                              ? femaleColorController.selectedColor.withValues(
                                alpha: 0.1,
                              )
                              : Color(0xffE6EBF0),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.darkBackgroundColor
                                : isFemale
                                ? Colors.transparent
                                : Color(0xff003366),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        dropdownColor:
                            themeMode == ThemeMode.dark
                                ? Color(0xff32383D)
                                : isFemale
                                ? AppColors.primary
                                : Color(0xffE6EBF0),
                        style: TextStyle(
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                        underline: Container(color: Colors.white),
                        value: dropdownValue.value,
                        icon: Image.asset(
                          IconPath.dropdown,
                          height: 7,
                          width: 11,
                          color:
                              isFemale
                                  ? femaleColorController.selectedColor
                                  : AppColors.cardDarkColor,
                        ),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            dropdownValue.value = newValue;
                          }
                        },
                        items:
                            <String>[
                              'All Task',
                              'Urgent',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 17),
                  Container(
                    height: 36,
                    width: 150,
                    decoration: BoxDecoration(
                      color:
                          themeMode == ThemeMode.dark
                              ? Color(0xff32383D)
                              : isFemale
                              ? femaleColorController.selectedColor.withValues(
                                alpha: 0.1,
                              )
                              : Color(0xffE6EBF0),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.darkBackgroundColor
                                : isFemale
                                ? Colors.transparent
                                : Color(0xff003366),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        dropdownColor:
                            themeMode == ThemeMode.dark
                                ? Color(0xff32383D)
                                : isFemale
                                ? AppColors.primary
                                : Color(0xffE6EBF0),

                        style: TextStyle(
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                        underline: Container(color: Colors.white),
                        value: dropdown.value,
                        icon: Image.asset(
                          IconPath.dropdown,
                          height: 7,
                          width: 11,
                          color:
                              isFemale
                                  ? femaleColorController.selectedColor
                                  : AppColors.cardDarkColor,
                        ),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            dropdown.value = newValue;
                          }
                        },
                        items:
                            <String>['By Date'].map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: checklistController.checklistItems.length,
                  itemBuilder: (context, index) {
                    final reverseIndex =
                        checklistController.checklistItems.length - 1 - index;
                    final dataItem =
                        checklistController.checklistItems[reverseIndex];
                    return EpCustomCheckListWidget(
                      item: dataItem,
                      index: index,
                      themeMode: themeMode,
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  Get.to(CreateChecklistScreen());
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
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.iconColor,
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
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.buttonColor
                                : isFemale
                                ? femaleColorController.selectedColor
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
                              : isFemale
                              ? femaleColorController.selectedColor
                              : AppColors.iconColor,
                    ),
                  ],
                ),
              ),
              // Obx(
              //   () => ListView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: checklistController.checklistItems.length,
              //     itemBuilder: (context, index) {
              //       final item = checklistController.checklistItems[index];
              //       return EpCustomCheckListWidget(item: item, index: index);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
