import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/controllers/checklist_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/create_checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Stateless widget for the Event Checklist screen to display saved checklist items or a "No Data" state
class EventChecklistScreen extends StatelessWidget {
  const EventChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ChecklistController instance to access the checklist items
    final ChecklistController controller = Get.put(ChecklistController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Set the background color
      appBar: _buildAppBar(), // Build the AppBar with only the three-dot menu
      body: Obx(() {
        // Use Obx to reactively update the UI based on the checklistItems list
        return Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the body
          child: Column(
            children: [
              // Show the filter section only if there are items in checklistItems
              if (controller.checklistItems.isNotEmpty) ...[
                Row(
                  children: [
                    // Dropdown for filtering tasks (ALL Task, Urgent, Completed)
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        value: controller.filterType.value, // Bind to filterType
                        items: ['ALL Task', 'Urgent', 'Completed']
                            .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(
                            label,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.filterType.value = value; // Update filter type
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
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        value: controller.sortType.value, // Bind to sortType
                        items: ['By Date', 'By Venue']
                            .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(
                            label,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.sortType.value = value; // Update sort type
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Space between dropdowns and content
              ],
              // Check if there are filtered items to display
              controller.filteredChecklistItems.isEmpty
                  ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display the "No Checklist" SVG image
                      SvgPicture.asset(ImagePath.nochecklist),
                      const SizedBox(height: 20), // Space between image and text
                      // "Nothing Found" text
                      Text(
                        'Noting Found',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4), // Space between text lines
                      // Description text
                      Text(
                        "You didn't added any task yes",
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff767676),
                        ),
                      ),
                      const SizedBox(height: 40), // Space between text and button
                      // "Add Task" button to navigate to CreateChecklistScreen
                      OutlinedButton(
                        onPressed: () {
                          Get.to(const CreateChecklistScreen());
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 12),
                          fixedSize: const Size(125, 44),
                          side: BorderSide(
                              color: AppColors.iconColor, width: 1.5),
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
                        itemCount: controller
                            .filteredChecklistItems.length, // Number of filtered items
                        itemBuilder: (context, index) {
                          final item = controller
                              .filteredChecklistItems[index]; // Get the current item
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12.0), // Space between list items
                            child: Row(
                              children: [
                                // Checkbox to mark the task as completed
                                Checkbox(
                                  value: item.isCompleted, // Checkbox state
                                  onChanged: (value) {
                                    // Find the index in the original list
                                    final originalIndex = controller
                                        .checklistItems
                                        .indexOf(item);
                                    controller.toggleCompletion(
                                        originalIndex); // Toggle completion status
                                  },
                                  activeColor:
                                  Colors.blue, // Color when checked
                                ),
                                // Task details container
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        12), // Padding inside the container
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors
                                              .grey), // Border around the container
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // Display the event name
                                        Text(
                                          item.eventName,
                                          style: getTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        // Display the task name if it exists and is not empty
                                        if (item.taskName != null &&
                                            item.taskName!.isNotEmpty) ...[
                                          const SizedBox(
                                              height:
                                              4), // Space between text
                                          Text(
                                            item.taskName!,
                                            style: getTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ],
                                        const SizedBox(
                                            height: 4), // Space between text
                                        // Display the venue
                                        Text(
                                          item.venue ?? 'No Venue',
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF003285),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 4), // Space between text
                                        // Display the date
                                        Text(
                                          item.taskDate != null
                                              ? DateFormat('dd MMM yyyy')
                                              .format(item.taskDate!)
                                              : 'No Date',
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                        height: 16), // Space between list and button
                    // "Add Task" button to navigate to the CreateChecklistScreen
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(
                              const CreateChecklistScreen()); // Navigate to create screen
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 12),
                          fixedSize: const Size(125, 44),
                          side: BorderSide(
                              color: AppColors.iconColor, width: 1.5),
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

  // Method to build the AppBar with only the three-dot menu
  AppBar _buildAppBar() {
    final ChecklistController controller = Get.find<ChecklistController>();

    return AppBar(
      backgroundColor: AppColors.backgroundColor, // Match the background color
      forceMaterialTransparency: true, // Make the AppBar transparent
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
        child: GestureDetector(
          onTap: () {
            Get.back(); // Navigate back when the back button is tapped
          },
          child: CircleAvatar(
            backgroundColor: const Color(0xFFD9D9D9), // Grey background for the back button
            child: Image.asset(IconPath.arrowLeftAlt), // Back arrow icon
          ),
        ),
      ),
      title: Text(
        'Checklist', // Title of the screen
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
        ),
      ),
      centerTitle: true, // Center the title
      actions: [
        // Three-dot menu button
        PopupMenuButton<String>(
          onSelected: (value) {
            // Handle the selected menu option
            if (value == 'Delete') {
              // Delete all items
              controller.checklistItems.clear();
              controller.updateFilteredList();
            } else if (value == 'Mark As Completed') {
              // Mark all items as completed
              for (var item in controller.checklistItems) {
                item.isCompleted = true;
              }
              controller.checklistItems.refresh();
              controller.updateFilteredList();
            } else if (value == 'Mark As Urgent') {
              // Mark all items as urgent
              for (var item in controller.checklistItems) {
                item.isUrgent = true;
              }
              controller.checklistItems.refresh();
              controller.updateFilteredList();
            } else if (value == 'Edit') {
              // For simplicity, we'll allow editing the first item if the list isn't empty
              if (controller.checklistItems.isNotEmpty) {
                controller.editItem(0); // Edit the first item
              }
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
            const PopupMenuItem<String>(
              value: 'Edit',
              child: Text('Edit'),
            ),
          ],
          icon: const Icon(Icons.more_vert, color: Colors.black), // Three-dot icon
        ),
      ],
    );
  }
}