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
    await showCustomTimePicker(isStartTime: isStartTime);
  }

  Future<void> showCustomTimePicker({required bool isStartTime}) async {
    final times = List.generate(
      24 * 4, // every 15 minutes
      (index) {
        final hour = index ~/ 4;
        final minute = (index % 4) * 15;
        return TimeOfDay(hour: hour, minute: minute);
      },
    );

    final selected = await showModalBottomSheet<TimeOfDay>(
      context: Get.context!,
      builder: (context) {
        return ListView.separated(
          itemCount: times.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (_, index) {
            final time = times[index];
            return ListTile(
              title: Text(time.format(context)),
              onTap: () {
                Navigator.pop(context, time);
              },
            );
          },
        );
      },
    );

    if (selected != null) {
      if (isStartTime) {
        startTime.value = selected;
      } else {
        endTime.value = selected;
      }
    }
  }

  var selectedEmployees = <Employee>[].obs;

  void setSelectedEmployees(List<Employee> employees) {
    selectedEmployees.assignAll(employees);
  }

  // New method to remove an employee
  void removeEmployee(Employee employee) {
    selectedEmployees.remove(employee);
  }
}
