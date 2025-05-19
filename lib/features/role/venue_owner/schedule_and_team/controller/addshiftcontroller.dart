import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/all_employee_model.dart'
    as all_employee;
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/employee_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Addshiftcontroller extends GetxController {
  final _logger = createLogger();
  final OwnerNetworkCaller _ownerNetworkCaller = OwnerNetworkCaller();

  var searchQuery = ''.obs;
  var employees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllEmployees();
  }

  // Fetch all employees
  Future<void> fetchAllEmployees() async {
    try {
      final response = await _ownerNetworkCaller.getRequest(
        Url: Urls.getAllEmployees,
        showLoading: false,
      );

      if (response.isSuccess) {
        final allEmployees = all_employee.AllEmployee.fromJson(response.body);
        employees.assignAll(
          allEmployees.employees
              .map(
                (e) => Employee(
                  id: e.id ?? '',
                  name: '${e.firstName ?? ''} ${e.lastName ?? ''}',
                  position: e.role ?? '',
                ),
              )
              .toList(),
        );
        filteredEmployees.assignAll(employees);
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

  // Update search
  void updateSearch(String query) {
    searchQuery.value = query.toLowerCase();
    if (query.isEmpty) {
      filteredEmployees.assignAll(employees);
    } else {
      filteredEmployees.assignAll(
        employees.where((employee) {
          return employee.name.toLowerCase().contains(searchQuery.value);
        }).toList(),
      );
    }
  }

  // Toggle checkbox for specific employee
  void toggleCheckbox(int index, bool? value) {
    filteredEmployees[index].isChecked.value = value ?? false;
  }
}
