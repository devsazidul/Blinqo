import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/create_checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventChecklistScreen extends StatelessWidget {
  const EventChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChecklistController controller = Get.put(ChecklistController());
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: _buildAppBar(),
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,

                              width: 3,
                              // Set the border color to red
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
                    // Dropdown for sorting (By Date, By Venue)
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.iconColor,
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
                          child: ListView.builder(
                            itemCount: 10, // Number of items in the list
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.10, // Height based on screen size
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
                                                  'Venue booking $index', // Example text for the venue
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors
                                                            .black, // Text color
                                                  ),
                                                ),
                                                Text(
                                                  'The Grand Hall',
                                                  style: TextStyle(
                                                    fontSize: 10.0,
                                                    color:
                                                        Colors
                                                            .grey, // Text color for smaller text
                                                  ),
                                                ),
                                                Text(
                                                  '20 Mar 2025',
                                                  style: TextStyle(
                                                    fontSize: 8.0,
                                                    color:
                                                        Colors
                                                            .grey, // Date text color
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Conditionally show the button when the index is selected
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 16),
                        Center(
                          child: OutlinedButton(
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
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar() {
    final ChecklistController controller = Get.find<ChecklistController>();

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
            child: Image.asset(IconPath.arrowLeftAlt),
          ),
        ),
      ),
      title: Text(
        'Checklist',
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
        ),
      ),
      centerTitle: true,
      actions: [
        PopupMenuButton<String>(
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
                const PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
                const PopupMenuItem<String>(
                  value: 'Mark As Completed',
                  child: Text('Mark As Completed'),
                ),
                const PopupMenuItem<String>(
                  value: 'Mark As Urgent',
                  child: Text('Mark As Urgent'),
                ),
                const PopupMenuItem<String>(value: 'Edit', child: Text('Edit')),
              ],
          icon: const Icon(Icons.more_vert, color: Colors.black),
        ),
      ],
    );
  }
}
