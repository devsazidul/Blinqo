import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/shif_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreateShiftController extends GetxController {
  final ShiftController shiftController = Get.find<ShiftController>();
  final OwnerNetworkCaller _networkCaller = OwnerNetworkCaller();

  var isLoading = false.obs;

  Future<void> createShift({
    required String venueId,
    required String shiftName,
  }) async {
    try {
      isLoading.value = true;

      // Validate for individual fields
      if (shiftName.isEmpty) {  
        EasyLoading.showError('Shift name is required');
        return;
      }
      if (shiftController.startTime.value == null) {
        EasyLoading.showError('Start time is required');
        return;
      }
      if (shiftController.endTime.value == null) {
        EasyLoading.showError('End time is required');
        return;
      }
      if (shiftController.selectedEmployees.isEmpty) {
        EasyLoading.showError('Please select at least one employee');
        return;
      }

      // Convert TimeOfDay to DateTime with today's date
      final now = DateTime.now();
      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        shiftController.startTime.value!.hour,
        shiftController.startTime.value!.minute,
      );

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        shiftController.endTime.value!.hour,
        shiftController.endTime.value!.minute,
      );

      // Prepare request body
      final Map<String, dynamic> body = {
        "ids": shiftController.selectedEmployees.map((e) => e.id).toList(),
        "venueId": venueId,
        "startTime": startDateTime.toUtc().toIso8601String(),
        "endTime": endDateTime.toUtc().toIso8601String(),
        "shiftName": shiftName,
      };

      final response = await _networkCaller.postRequest(
        Url: Urls.createShift,
        body: body,
      );

      if (response.isSuccess) {
        EasyLoading.showSuccess('Shift created successfully');
        // call fetch all shifts
        shiftController.fetchAllShifts(venueId);
        clearAllControllers();

      } else {
        EasyLoading.showError(
          response.errorMessage ?? 'Failed to create shift',
        );
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearAllControllers() {
    shiftController.startTime.value = null;
    shiftController.endTime.value = null;
    shiftController.selectedEmployees.clear();
  }
}
