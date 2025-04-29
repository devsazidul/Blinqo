// import 'package:get/get.dart';

// class CheckVenueController extends GetxController {
//   var isDroppeddownOpen = false.obs;
//   var selectedTask = 'All Task'.obs;

//   var isDateDropdownOpen = false.obs;
//   var selectedDate = 'By Date'.obs;
//   RxBool isChecked = false.obs;

//   void toggleCheckbox(bool? value) {
//     isChecked.value = value ?? false;
//   }

//   void toggleDropdown() {
//     isDroppeddownOpen.value = !isDroppeddownOpen.value;
//   }

//   void selectTask(String task) {
//     selectedTask.value = task;
//     isDroppeddownOpen.value = false;
//   }

//   void toggleDateDropdown() {
//     isDateDropdownOpen.value = !isDateDropdownOpen.value;
//   }

//   void selectDate(String date) {
//     selectedDate.value = date;
//     isDateDropdownOpen.value = false;
//   }

//   var checklistItems = <CheckListItem>[].obs;
// }

// class CheckListItem {
//   String title;
//   String location;
//   String date;
//   String time;
//   RxBool isChecked;

//   CheckListItem({
//     required this.title,
//     required this.location,
//     required this.date,
//     required this.time,
//     required this.isChecked,
//   });
// }
