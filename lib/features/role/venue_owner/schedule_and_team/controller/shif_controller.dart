import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/employee_model.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/shift_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ShiftController extends GetxController {
  final _logger = createLogger();
  final OwnerNetworkCaller _networkCaller = OwnerNetworkCaller();

  var startTime = Rx<TimeOfDay?>(null);
  var endTime = Rx<TimeOfDay?>(null);
  var selectedEmployees = <Employee>[].obs;
  var shifts = <ShiftData>[].obs;
  var isLoading = false.obs;
  var isEditMode = false.obs;
  var currentShiftId = ''.obs;

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

  void setSelectedEmployees(List<Employee> employees) {
    selectedEmployees.assignAll(employees);
  }

  void removeEmployee(Employee employee) {
    selectedEmployees.remove(employee);
  }

  // Fetch all shifts
  Future<void> fetchAllShifts(String venueId) async {
    try {
      isLoading.value = true;
      final response = await _networkCaller.getRequest(
        Url: Urls.getAllShifts(venueId),
        showLoading: false,
      );

      if (response.isSuccess) {
        final shiftResponse = ShiftResponse.fromJson(response.body);
        shifts.assignAll(shiftResponse.data);
      } else {
        EasyLoading.showError(
          response.errorMessage ?? 'Failed to fetch shifts',
        );
      }
    } catch (e) {
      _logger.e('Error fetching shifts: $e');
      EasyLoading.showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch single shift
  Future<ShiftData?> fetchSingleShift(String shiftId) async {
    try {
      final response = await _networkCaller.getRequest(
        Url: Urls.getSingleShift(shiftId),
        showLoading: false,
      );

      if (response.isSuccess) {
        return ShiftData.fromJson(response.body);
      } else {
        EasyLoading.showError(
          response.errorMessage ?? 'Failed to fetch shift details',
        );
        return null;
      }
    } catch (e) {
      _logger.e('Error fetching shift: $e');
      EasyLoading.showError('Error: $e');
      return null;
    }
  }

  // Update shift
  Future<void> updateShift({
    required String shiftId,
    required String venueId,
    required String shiftName,
  }) async {
    try {
      isLoading.value = true;

      // Validate required fields
      if (shiftName.isEmpty) {
        EasyLoading.showError('Shift name is required');
        return;
      }
      if (startTime.value == null) {
        EasyLoading.showError('Start time is required');
        return;
      }
      if (endTime.value == null) {
        EasyLoading.showError('End time is required');
        return;
      }
      if (selectedEmployees.isEmpty) {
        EasyLoading.showError('Please select at least one employee');
        return;
      }

      // Convert TimeOfDay to DateTime
      final now = DateTime.now();
      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        startTime.value!.hour,
        startTime.value!.minute,
      );

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        endTime.value!.hour,
        endTime.value!.minute,
      );

      final Map<String, dynamic> body = {
        "ids": selectedEmployees.map((e) => e.id).toList(),
        "venueId": venueId,
        "startTime": startDateTime.toUtc().toIso8601String(),
        "endTime": endDateTime.toUtc().toIso8601String(),
        "shiftName": shiftName,
      };

      final response = await _networkCaller.postRequest(
        Url: Urls.updateShift(shiftId),
        body: body,
        isPatch: true,
      );

      if (response.isSuccess) {
        EasyLoading.showSuccess('Shift updated successfully');
        await fetchAllShifts(venueId);
        Get.back();
      } else {
        EasyLoading.showError(
          response.errorMessage ?? 'Failed to update shift',
        );
      }
    } catch (e) {
      _logger.e('Error updating shift: $e');
      EasyLoading.showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete shift
  Future<void> deleteShift(String shiftId, String venueId) async {
    try {
      final response = await _networkCaller.deleteRequest(
        Url: Urls.deleteShift(shiftId),
      );

      if (response.isSuccess) {
        EasyLoading.showSuccess('Shift deleted successfully');
        await fetchAllShifts(venueId);
      } else {
        EasyLoading.showError(
          response.errorMessage ?? 'Failed to delete shift',
        );
      }
    } catch (e) {
      _logger.e('Error deleting shift: $e');
      EasyLoading.showError('Error: $e');
    }
  }

  // Load shift data for editing
  void loadShiftForEditing(ShiftData shift) {
    isEditMode.value = true;
    currentShiftId.value = shift.id;

    // Convert DateTime to TimeOfDay
    startTime.value = TimeOfDay(
      hour: shift.startTime.hour,
      minute: shift.startTime.minute,
    );

    endTime.value = TimeOfDay(
      hour: shift.endTime.hour,
      minute: shift.endTime.minute,
    );

    // Convert ShiftEmployee to Employee
    selectedEmployees.assignAll(
      shift.employee.map((e) => e.toEmployee()).toList(),
    );
  }

  // Reset form
  void resetForm() {
    isEditMode.value = false;
    currentShiftId.value = '';
    startTime.value = null;
    endTime.value = null;
    selectedEmployees.clear();
  }
}
