import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/all_employee_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MyTeamTabController extends GetxController {
  final _logger = createLogger();
  final OwnerNetworkCaller _ownerNetworkCaller = OwnerNetworkCaller();

  final RxList<Employee> teamList = <Employee>[].obs;
  final RxList<Employee> filteredTeamList = <Employee>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllEmployees();
  }

  // fetch all employees
  Future<void> fetchAllEmployees() async {
    try {
      final response = await _ownerNetworkCaller.getRequest(
        Url: Urls.getAllEmployees,
        showLoading: false,
      );

      if (response.isSuccess) {
        final allEmployees = AllEmployee.fromJson(response.body);
        teamList.assignAll(allEmployees.employees);
        filteredTeamList.assignAll(teamList);
      } else {
        _logger.w('Failed to fetch employees: ${response.errorMessage}');
        EasyLoading.showError(
          'Failed to load employees: ${response.errorMessage}',
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Error fetching employees: $e', stackTrace: stackTrace);
      EasyLoading.showError('Error: $e');
    }
  }

  // update search
  void updateSearch(String query) {
    searchQuery.value = query.toLowerCase();
    if (query.isEmpty) {
      filteredTeamList.assignAll(teamList);
    } else {
      filteredTeamList.assignAll(
        teamList.where((employee) {
          final fullName =
              '${employee.firstName ?? ''} ${employee.lastName ?? ''}'
                  .toLowerCase();
          return fullName.contains(searchQuery.value);
        }).toList(),
      );
    }
    _logger.i(
      'Filtered team list updated: ${filteredTeamList.length} employees',
    );
  }

  // add team member from contact
  void addTeamMembercontact(
    Map<String, dynamic> contact,
    String venueId,
  ) async {
    _logger.i('Adding team member from contact: $contact');

    try {
      EasyLoading.show(status: 'Adding team member...');

      final nameParts = contact['name']?.split(' ') ?? ['Unknown'];
      final firstName = nameParts.first;
      final lastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      // Prepare request body
      final Map<String, dynamic> requestBody = {
        'venueId': venueId,
        'firstName': firstName,
        'lastName': lastName,
        'email': contact['email'],
        'phone': contact['phone'],
        'role': contact['role'],
      };

      // Make API call to create employee
      final response = await _ownerNetworkCaller.postRequest(
        Url: Urls.createEmployee,
        body: requestBody,
        showLoading: false,
      );

      if (response.isSuccess) {
        // Refresh the employee list
        await fetchAllEmployees();
        EasyLoading.showSuccess('Team member added successfully');
      } else {
        _logger.w('Failed to add employee: ${response.errorMessage}');
        EasyLoading.showError(
          'Failed to add employee: ${response.errorMessage}',
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Error adding employee: $e', stackTrace: stackTrace);
      EasyLoading.showError('Error: $e');
    }
  }

  // Delete team member
  Future<void> deleteTeamMember(int index) async {
    try {
      final employee = filteredTeamList[index];

      // Make API call to delete employee
      final response = await _ownerNetworkCaller.deleteRequest(
        Url: Urls.deleteEmployee(employee.id ?? ''),
        showLoading: true,
      );

      if (response.isSuccess) {
        // Remove from local lists
        teamList.removeWhere((e) => e.id == employee.id);
        filteredTeamList.removeWhere((e) => e.id == employee.id);
        await fetchAllEmployees();
        EasyLoading.showSuccess('Team member deleted successfully');
      } else {
        await fetchAllEmployees();
        EasyLoading.showError(
          'Failed to delete employee: ${response.errorMessage}',
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Error deleting employee: $e', stackTrace: stackTrace);
      EasyLoading.showError('Error: $e');
    }
  }
}
