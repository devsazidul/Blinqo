import 'package:blinqo/features/role/event_planner/event_checkout_page/model/checklist_model.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/create_checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Controller class to manage checklist creation and listing
class ChecklistController extends GetxController {
  // Reactive variable to toggle the visibility of the task form in CreateChecklistScreen
  var isTaskFormVisible = false.obs;

  // Reactive variables to store form inputs
  var selectedDate = DateTime.now().obs; // Selected date for the task
  var selectedTime =
      TimeOfDay(hour: 0, minute: 0).obs; // Selected time for the task
  var eventName = ''.obs; // Event Name input
  var taskName = ''.obs; // Task Name input
  var venue = ''.obs; // Venue input (optional)
  var isDateSelected = false.obs; // Track if a date is explicitly selected
  var isTimeSelected = false.obs; // Track if a time is explicitly selected

  // Reactive list to store all checklist items (in-memory storage)
  var checklistItems = <ChecklistModel>[].obs;

  // Reactive variables for filtering and sorting
  var filterType =
      'ALL Task'.obs; // Current filter type (ALL Task, Urgent, Completed)
  var sortType = 'By Date'.obs; // Current sort type (By Date, By Venue)

  // Filtered and sorted list of checklist items
  var filteredChecklistItems = <ChecklistModel>[].obs;

  // Controllers for TextFields to clear them after saving
  final eventNameController = TextEditingController();
  final taskNameController = TextEditingController();
  final venueController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize the filtered list with all items
    filteredChecklistItems.assignAll(checklistItems);
    // Listen to changes in checklistItems, filterType, and sortType to update the filtered list
    ever(checklistItems, (_) => updateFilteredList());
    ever(filterType, (_) => updateFilteredList());
    ever(sortType, (_) => updateFilteredList());
  }

  // Method to toggle the visibility of the task form
  void toggleTaskForm() {
    isTaskFormVisible.value = !isTaskFormVisible.value;
  }

  // Method to show a date picker and update the selected date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      isDateSelected.value = true; // Mark date as selected
    }
  }

  // Method to show a time picker and update the selected time
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
      isTimeSelected.value = true; // Mark time as selected
    }
  }

  // Format the selected date as "dd.MM.yyyy"
  String getFormattedDate() {
    return DateFormat('dd.MM.yyyy').format(selectedDate.value);
  }

  // Format the selected time as per the device's time format
  String getFormattedTime(BuildContext context) {
    return selectedTime.value.format(context);
  }

  // Validate if all required fields are filled
  bool areFieldsFilled() {
    return eventName.value.isNotEmpty &&
        (isTaskFormVisible.value
            ? (taskName.value.isNotEmpty &&
                isDateSelected.value &&
                isTimeSelected.value)
            : true);
  }

  // Method to save the checklist item
  void saveChecklist() {
    // Create a new ChecklistModel instance with the current form data
    final checklistItem = ChecklistModel(
      eventName: eventName.value,
      taskName: isTaskFormVisible.value ? taskName.value : null,
      taskDate: isTaskFormVisible.value ? selectedDate.value : null,
      taskTime: isTaskFormVisible.value ? selectedTime.value : null,
      venue: isTaskFormVisible.value ? venue.value : null,
    );

    // Add the item to the checklistItems list (in-memory storage)
    checklistItems.add(checklistItem);

    // Clear the form fields
    clearFields();

    // Show a success notification using Get.snackbar
    Get.snackbar(
      'Success',
      'Checklist item added successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // No navigation to EventChecklistScreen; user stays on CreateChecklistScreen
  }

  // Method to clear all form fields after saving
  void clearFields() {
    eventName.value = '';
    taskName.value = '';
    venue.value = '';
    isTaskFormVisible.value = false;
    selectedDate.value = DateTime.now();
    selectedTime.value = const TimeOfDay(hour: 0, minute: 0);
    isDateSelected.value = false;
    isTimeSelected.value = false;
    eventNameController.clear();
    taskNameController.clear();
    venueController.clear();
  }

  // Method to toggle the completion status of a checklist item
  void toggleCompletion(int index) {
    checklistItems[index].isCompleted = !checklistItems[index].isCompleted;
    checklistItems.refresh(); // Refresh the list to update the UI
    updateFilteredList(); // Update the filtered list
  }

  // Method to mark a checklist item as urgent
  void markAsUrgent(int index) {
    checklistItems[index].isUrgent = !checklistItems[index].isUrgent;
    checklistItems.refresh(); // Refresh the list to update the UI
    updateFilteredList(); // Update the filtered list
  }

  // Method to delete a checklist item
  void deleteItem(int index) {
    checklistItems.removeAt(index);
    updateFilteredList(); // Update the filtered list
  }

  // Method to edit a checklist item (navigate back to CreateChecklistScreen with pre-filled data)
  void editItem(int index) {
    final item = checklistItems[index];
    eventName.value = item.eventName;
    taskName.value = item.taskName ?? '';
    venue.value = item.venue ?? '';
    selectedDate.value = item.taskDate ?? DateTime.now();
    selectedTime.value = item.taskTime ?? const TimeOfDay(hour: 0, minute: 0);
    isDateSelected.value = item.taskDate != null;
    isTimeSelected.value = item.taskTime != null;
    isTaskFormVisible.value = item.taskName != null;
    eventNameController.text = item.eventName;
    taskNameController.text = item.taskName ?? '';
    venueController.text = item.venue ?? '';

    // Remove the item from the list (it will be re-added on save)
    checklistItems.removeAt(index);
    updateFilteredList();

    // Navigate to CreateChecklistScreen for editing
    Get.to(() => const CreateChecklistScreen());
  }

  // Method to update the filtered and sorted list based on filterType and sortType
  void updateFilteredList() {
    // Filter the list based on filterType
    List<ChecklistModel> filteredList = [];
    if (filterType.value == 'ALL Task') {
      filteredList = checklistItems.toList();
    } else if (filterType.value == 'Urgent') {
      filteredList = checklistItems.where((item) => item.isUrgent).toList();
    } else if (filterType.value == 'Completed') {
      filteredList = checklistItems.where((item) => item.isCompleted).toList();
    }

    // Sort the filtered list based on sortType
    if (sortType.value == 'By Date') {
      filteredList.sort((a, b) {
        if (a.taskDate == null || b.taskDate == null) return 0;
        return a.taskDate!.compareTo(b.taskDate!);
      });
    } else if (sortType.value == 'By Venue') {
      filteredList.sort((a, b) {
        if (a.venue == null || b.venue == null) return 0;
        return a.venue!.compareTo(b.venue!);
      });
    }

    // Update the filteredChecklistItems
    filteredChecklistItems.assignAll(filteredList);
  }

  // Track the index of the selected checkbox
  var selectedIndex = (-1).obs; // -1 means no checkbox is selected initially

  // Function to toggle checkbox state
  void toggleCheckbox(int index, bool value) {
    if (value) {
      selectedIndex.value = index; // Set selected index when checked
    } else {
      selectedIndex.value = -1; // Reset when unchecked
    }
  }
}
