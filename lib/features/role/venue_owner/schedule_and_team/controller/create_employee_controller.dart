import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/my_team_tab_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreateEmployeeController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  String? employeeId;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['isEdit'] == true) {
      isEdit = true;
      loadData(Get.arguments['index']);
    }
  }

  MyTeamTabController myTeamTabController = Get.put(MyTeamTabController());

  // load data when user is editing from my team tab screen
  void loadData(int index) {
    final employee = myTeamTabController.filteredTeamList[index];
    employeeId = employee.id;
    firstNameController.text = employee.firstName ?? '';
    lastNameController.text = employee.lastName ?? '';
    emailController.text = employee.email ?? '';
    phoneController.text = employee.phone ?? '';
    roleController.text = employee.role ?? '';

  }

  Future<void> createEmployee(String venueId) async {
    try {
      final Map<String, dynamic> body = {
        "venueId": venueId,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "address": addressController.text,
        "phone": phoneController.text,
        "role": roleController.text,
      };

      final response =
          isEdit
              ? await OwnerNetworkCaller().postRequest(
                Url: Urls.updateEmployee(employeeId!),
                body: body,
                isPatch: true,
              )
              : await OwnerNetworkCaller().postRequest(
                Url: Urls.createEmployee,
                body: body,
              );

      if (response.isSuccess) {
        EasyLoading.showSuccess(
          isEdit
              ? 'Employee updated successfully'
              : 'Employee created successfully',
        );
        if (isEdit) {
          await myTeamTabController.fetchAllEmployees();
          Get.back();
        } else {
          await myTeamTabController.fetchAllEmployees();
          clearAllControllers();
          Get.back();
        }
      } else {
        EasyLoading.showError(
          response.errorMessage ??
              'Failed to ${isEdit ? 'update' : 'create'} employee',
        );
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
    }
  }

  void clearAllControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    addressController.clear();
    phoneController.clear();
    roleController.clear();
    employeeId = null;
    isEdit = false;
  }

  @override
  void onClose() {
    clearAllControllers();
    super.onClose();
  }
}
