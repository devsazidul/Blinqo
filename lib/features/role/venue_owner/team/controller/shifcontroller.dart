import 'package:blinqo/features/role/venue_owner/team/controller/addshiftcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShiftController extends GetxController {
  var startTime = Rx<TimeOfDay?>(null);
  var endTime = Rx<TimeOfDay?>(null);
  String get duration {
    if (startTime.value != null && endTime.value != null) {
      final start = startTime.value!;
      final end = endTime.value!;
      final startMinutes = start.hour * 60 + start.minute;
      final endMinutes = end.hour * 60 + end.minute;
      final diff = endMinutes - startMinutes;
      if (diff > 0) {
        final hours = diff ~/ 60;
        final minutes = diff % 60;
        return "${hours}h ${minutes}m";
      }
    }
    return "0h 0m";
  }

  Future<void> pickTime({required bool isStartTime}) async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStartTime) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
    }
  }

  var selectedEmployees = <Employee>[].obs;

  // Function to set selected employees
  void setSelectedEmployees(List<Employee> employees) {
    selectedEmployees.assignAll(employees);
  }
}
