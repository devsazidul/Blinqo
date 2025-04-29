import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/model/checklist_model.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/build_checkappbar.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/check_venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChecklistScreen extends StatelessWidget {
  const CreateChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final profileController = Get.find<ProfileController>();
    final ChecklistController controller = Get.put(ChecklistController());
     final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    return Scaffold(
       backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.borderColor2,
      appBar: buildCheckVenueAppBar(),
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
                  color: themeMode==ThemeMode.dark?Color(0xffD4AF37):Color(0xff003285),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: controller.eventNameController,
                onChanged: (value) {
                  controller.eventName.value = value;
                },
                style: getTextStyle(
                 color: themeMode==ThemeMode.dark?Colors.white:Colors.black,
                ),
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
                    color: themeMode==ThemeMode.dark?Color(0xff868686):AppColors.textColor,
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
                            color: themeMode==ThemeMode.dark?Color(0xffD4AF37):AppColors.iconColor ,
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
                                color:themeMode==ThemeMode.dark?Color(0xffD4AF37):AppColors.iconColor ,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.add_circle_outline_outlined,
                              size: 24,
                              color:themeMode==ThemeMode.dark?Color(0xffD4AF37):AppColors.iconColor ,
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
                          color: themeMode==ThemeMode.dark?Color(0xffEBEBEB):Color(0xFF003285),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Task Name',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: themeMode==ThemeMode.dark?Color(0xffD4AF37):const Color(0xFF003285),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        onChanged: (value) {
                          controller.taskName.value = value;
                        },
                        style: getTextStyle(
                 color: themeMode==ThemeMode.dark?Colors.white:Colors.black,
                ),
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
                            color:themeMode==ThemeMode.dark?Color(0xff868686):AppColors.textColor,
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
                          color: themeMode==ThemeMode.dark?Color(0xffD4AF37):const Color(0xFF003285),
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
                              color:themeMode==ThemeMode.dark?Color(0xff32383D):Color(0xFFE6E6E6),
                              width: 1,
                            ),
                            color: themeMode==ThemeMode.dark?Color(0xff32383D):Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color:themeMode==ThemeMode.dark?Color(0xffD4AF37):AppColors.iconColor,
                              ),
                              SizedBox(width: 4),
                              Column(
                                children: [
                                  Text(
                                    'Select a day',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: themeMode==ThemeMode.dark?Color(0xffEBEBEB):Color(0xff333333)
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.getFormattedDate(),
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: themeMode==ThemeMode.dark?Color(0xffD4AF37):AppColors.iconColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),
                              Transform.rotate(
                                angle: 256,
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color:themeMode==ThemeMode.dark?Color(0xffEBEBEB):Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Text(
                        'Set Time',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: themeMode==ThemeMode.dark?Color(0xffD4AF37):const Color(0xFF003285),
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
                              color: themeMode==ThemeMode.dark?Color(0xff32383D):Color(0xFFE6E6E6),
                              width: 1,
                            ),
                            color: themeMode==ThemeMode.dark?Color(0xff32383D):Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: themeMode==ThemeMode.dark?Color(0xffD4AF37):AppColors.iconColor,
                              ),
                              SizedBox(width: 4),
                              Column(
                                children: [
                                  Text(
                                    'Start time',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                     color:  themeMode==ThemeMode.dark?Color(0xffEBEBEB):Color(0xff333333)
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.getFormattedTime(context),
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: themeMode==ThemeMode.dark?Color(0xffD4AF37):const Color(0xFF003285),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            Spacer(),
                              Transform.rotate(
                                angle: 256,
                                child:  Icon(
                                  Icons.arrow_back_ios_new,
                                color:themeMode==ThemeMode.dark?Color(0xffEBEBEB):Color(0xff333333),
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
  return
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed:  () {
            controller.checklistItems.add(
              ChecklistModel(
                eventName: controller.eventName.value,
                taskName: controller.taskName.value,
                taskDate: controller.selectedDate.value,
                taskTime: controller.selectedTime.value,
                venue: controller.eventName.value,
                isCompleted: false,
                isUrgent: false,
              ),
            );
            controller.clearFields();
            Get.to(
              () => CheckVenue(
                eventName: controller.eventName.value,
                taskName: controller.taskName.value,
                selectedDate: controller.getFormattedDate(),
                selectedTime: controller.getFormattedTime(context),
              ),
            );
          }
     ,
    style: ElevatedButton.styleFrom(
      backgroundColor: themeMode == ThemeMode.dark 
      ? (isEnabled 
          ?  AppColors.buttonColor2
          :  AppColors.buttonColor2) : (isEnabled?AppColors.buttonColor2:AppColors.buttonColor),
      foregroundColor: isEnabled
          ? AppColors.buttonColor2// Enabled text color
          : Colors.red, // Disabled text
      elevation: 0,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: themeMode == ThemeMode.dark && isEnabled ? Color(0xFF003366) : Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child:  Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        'Save',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color:  themeMode == ThemeMode.dark 
      ? (isEnabled 
          ?  AppColors.primary
          : AppColors.borderColor) : (isEnabled?AppColors.primary:AppColors.borderColor),
        ),
      ),
    ),
  ),
);
 
 //  SizedBox(
  //   width: double.infinity,
  //   child: ElevatedButton(
  //     onPressed: isEnabled
  //         ? () {
  //             controller.checklistItems.add(
  //               ChecklistModel(
  //                 eventName: controller.eventName.value,
  //                 taskName: controller.taskName.value,
  //                 taskDate: controller.selectedDate.value,
  //                 taskTime: controller.selectedTime.value,
  //                 venue: controller.eventName.value,
  //                 isCompleted: false,
  //                 isUrgent: false,
  //               ),
  //             );
  //             controller.clearFields();
  //             Get.to(
  //               () => CheckVenue(
  //                 eventName: controller.eventName.value,
  //                 taskName: controller.taskName.value,
  //                 selectedDate: controller.getFormattedDate(),
  //                 selectedTime: controller.getFormattedTime(context),
  //               ),
  //             );
  //           }
  //         : null,
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: isEnabled
  //           ? themeMode == ThemeMode.dark
  //               ? Color(0xff003366)
  //               : Color(0xff003366)
  //           : themeMode == ThemeMode.dark
  //               ? Colors.grey[700] // Dark mode disabled background color
  //               : Color(0xffE6EBF0), // Light mode disabled background color
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 12.0),
  //       child: Text(
  //         'Save',
  //         style: getTextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w500,
  //           color: isEnabled
  //               ? themeMode == ThemeMode.dark 
  //                   ? Color(0xffFFFFFF)
  //                   : Colors.white
  //               : themeMode == ThemeMode.dark
  //                   ? Color(0xff8AA1B9) // Dark mode disabled text color
  //                   : Color(0xff8AA1B9), // Light mode disabled text color
  //         ),
  //       ),
  //     ),
  //   ),
  // );




}),

            ],
          ), 
        ),
      ),
    );
  }
}
