import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/model/checklist_model.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCustomCheckListWidget extends StatelessWidget {
  final ChecklistModel item;
  final int index;
  final ThemeMode themeMode;

  EpCustomCheckListWidget({
    super.key,
    required this.item,
    required this.index,
    required this.themeMode,
  });

  final ChecklistController checklistController = Get.put(
    ChecklistController(),
  );

  @override
  Widget build(BuildContext context) {
    final femaleColorController = Get.put(PickColorController());
    final bool isFemale = femaleColorController.isFemale.value;

    return Obx(
      () => Card(
        elevation: 0,
        color:
            themeMode == ThemeMode.dark ? Color(0xff32383D) : AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              Checkbox(
                activeColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.buttonColor
                        : Colors.red,
                checkColor: isFemale ? AppColors.borderColor2 : null,
                value: checklistController.isSelected(index),
                onChanged: (value) {
                  checklistController.toggleSelection(index);
                },
                side: BorderSide(
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                  width: 2.0,
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.venue ?? '',
                      style: getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : isFemale
                                ? femaleColorController.selectedColor
                                : AppColors.buttonColor2,
                      ),
                    ),
                    Text(
                      item.taskName ?? '',
                      style: getTextStyle(
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : Color(0xff999999),
                      ),
                    ),

                    Text(
                      item.taskDate != null
                          ? "${item.taskDate!.day}.${item.taskDate!.month}.${item.taskDate!.year}"
                          : '',
                      style: getTextStyle(color: Color(0xff999999)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (!checklistController.isSelected(index))
                    Text(
                      item.taskTime != null
                          ? item.taskTime!.format(context)
                          : '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  if (checklistController.isSelected(
                    index,
                  )) // Show delete button when selected
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : isFemale
                                ? femaleColorController.selectedColor
                                : AppColors.buttonColor2,
                      ),
                      onPressed: () {
                        checklistController.deleteItem(
                          index,
                        ); // Call delete method
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
