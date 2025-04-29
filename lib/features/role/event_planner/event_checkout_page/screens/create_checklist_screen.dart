import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/model/checklist_model.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/check_venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChecklistScreen extends StatelessWidget {
  const CreateChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
final ChecklistController controller = Get.find<ChecklistController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Name',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF003285),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: controller.eventNameController,
                  onChanged: (value) {
                    controller.eventName.value =
                        value; // Update eventName reactively
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Color(0xFFABB7C2),
                        width: 1,
                      ),
                    ),
                    hintText: 'Event Name',
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!controller.isTaskFormVisible.value)
                        OutlinedButton(
                          onPressed: () {
                            controller.toggleTaskForm();
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
                      if (controller.isTaskFormVisible.value) ...[
                        Text(
                          'Task',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF003285),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Task Name',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF003285),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          onChanged: (value) {
                            controller.taskName.value =
                                value; // Update taskName reactively
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Color(0xFFABB7C2),
                                width: 1,
                              ),
                            ),
                            hintText: 'Task Name',
                            hintStyle: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Set Date
                        Text(
                          'Set Date',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF003285),
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => controller.selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE6E6E6),
                                width: 1,
                              ),
                              color: Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: AppColors.iconColor,
                                ),
                                SizedBox(width: 4),
                                Column(
                                  children: [
                                    Text(
                                      'Select a day',
                                      style: getTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.getFormattedDate(),
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF003285),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),
                                Transform.rotate(
                                  angle: 256,
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.iconColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Set Time
                        Text(
                          'Set Time',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF003285),
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => controller.selectTime(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE6E6E6),
                                width: 1,
                              ),
                              color: Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: AppColors.iconColor,
                                ),
                                SizedBox(width: 4),
                                Column(
                                  children: [
                                    Text(
                                      'Start time',
                                      style: getTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.getFormattedTime(context),
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF003285),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Transform.rotate(
                                  angle: 256,
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.iconColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                }),
                SizedBox(height: 40),
                Obx(() {
                  final isEnabled = controller.areFieldsFilled();
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          isEnabled
                              ? () {
                                controller.checklistItems.add(
                                  ChecklistModel(
                                    eventName: controller.eventName.value,
                                    taskName: controller.taskName.value,
                                    taskDate: controller.selectedDate.value,
                                    taskTime: controller.selectedTime.value,
                                    venue:
                                        controller
                                            .eventName
                                            .value, // 🔥 eventName as venue
                                    isCompleted: false,
                                    isUrgent: false,
                                  ),
                                );

                                // Optional: Clear fields after saving
                                controller.clearFields();

                                // Navigate to CheckVenue page
                                Get.to(
                                  () => CheckVenue(
                                    eventName: controller.eventName.value,
                                    taskName: controller.taskName.value,
                                    selectedDate: controller.getFormattedDate(),
                                    selectedTime: controller.getFormattedTime(
                                      context,
                                    ),
                                  ),
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isEnabled
                                ? const Color(0xFF003366)
                                : const Color(0xFFE6EBF0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Save',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                isEnabled
                                    ? Colors.white
                                    : const Color(0xFF8AA1B9),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: const Color(0xFFD9D9D9),
            child: Image.asset(IconPath.arrowLeftAlt, width: 20),
          ),
        ),
      ),
      title: Text(
        'Create Checklist',
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
        ),
      ),
      centerTitle: true,
    );
  }
}
