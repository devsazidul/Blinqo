import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/model/checklist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCustomCheckListWidget extends StatelessWidget {
  final ChecklistModel item;
  final int index;
  final ThemeMode themeMode;

  EpCustomCheckListWidget({super.key, required this.item, required this.index, required this.themeMode});
  final ChecklistController checklistController = Get.put(
    ChecklistController(),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 0,
        color: themeMode == ThemeMode.dark? Color(0xff32383D): AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Row(
            children: [
              Checkbox(
                value: checklistController.isSelected(index),
                onChanged: (value) {
                  checklistController.toggleSelection(index);
                },
                side: BorderSide(color: themeMode == ThemeMode.dark ? AppColors.borderColor2: AppColors.buttonColor2, width: 2.0),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.taskName ?? '',
                      style: getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: themeMode == ThemeMode.dark ? AppColors.borderColor2: AppColors.buttonColor2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.venue ?? '',
                      style: getTextStyle(color: themeMode == ThemeMode.dark ? AppColors.borderColor2: Color(0xff999999)),
                    ),
                    const SizedBox(height: 2),

                    Text(
                      item.taskDate != null
                          ? "${item.taskDate!.day}.${item.taskDate!.month}.${item.taskDate!.year}"
                          : '',
                      style: getTextStyle(color: Color(0xff999999)),
                    ),
                  ],
                ),
              ),
              if (!checklistController.isSelected(index))
                Text(
                  item.taskTime != null ? item.taskTime!.format(context) : '',
                  style: const TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
