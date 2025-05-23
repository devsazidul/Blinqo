import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../event_home_page/mixin/service_management_mixin.dart';
import '../../event_home_page/sharch_start_booking/mixin/amenities.dart';
import '../../event_home_page/sharch_start_booking/mixin/sharch_set_price.dart';

class BookingController extends GetxController
    with ServiceManagementMixin, Amenities, SharchSetPrice {

  final eventNameController = TextEditingController();
  final eventPlannerNameController = TextEditingController();
  final numberOfGuestsController = TextEditingController();

  final tableShapeController = TextEditingController();
  final seatingStyleController = TextEditingController();
  final lightingController = TextEditingController();
  final flowerColorController = TextEditingController();
  final flowerTypeController = TextEditingController();
  final fragranceController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var isDateSelected = false.obs;
  var isStartTimeSelected = false.obs;
  var isEndTimeSelected = false.obs;
  var selectedCountry = ''.obs;

  // Set the initial start time to 12:00 PM
  var selectedStartTime = TimeOfDay(hour: 0, minute: 0).obs;

  // Set the initial end time to 1:00 PM
  var selectedEndTime = TimeOfDay(hour: 0, minute: 0).obs;

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

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime.value,
    );
    if (picked != null && picked != selectedStartTime.value) {
      selectedStartTime.value = picked;
      isStartTimeSelected.value = true; // Mark start time as selected
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime.value,
    );
    // Ensure the end time is after the start time
    if (picked != null && picked != selectedEndTime.value) {
      if (_isEndTimeValid(picked)) {
        selectedEndTime.value = picked;
        isEndTimeSelected.value = true; // Mark end time as selected
      } else {
        // Optionally, you could show an error message here if the end time is not valid
        // print("End time must be later than start time");
      }
    }
  }

  // Helper method to check if the selected end time is later than the start time
  bool _isEndTimeValid(TimeOfDay pickedEndTime) {
    int startTimeInMinutes =
        selectedStartTime.value.hour * 60 + selectedStartTime.value.minute;
    int endTimeInMinutes = pickedEndTime.hour * 60 + pickedEndTime.minute;

    return endTimeInMinutes > startTimeInMinutes;
  }

  String getFormattedDate() {
    return DateFormat('dd.MM.yyyy').format(selectedDate.value);
  }

  String getFormattedStartTime(BuildContext context) {
    return selectedStartTime.value.format(context);
  }

  String getFormattedEndTime(BuildContext context) {
    return selectedEndTime.value.format(context);
  }
}
