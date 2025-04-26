import 'package:get/get.dart';

class Employee {
  String name;
  String position;
  RxBool isChecked;

  Employee({
    required this.name,
    required this.position,
    bool isChecked = false,
  }) : isChecked = isChecked.obs;
}

class Addshiftcontroller extends GetxController {
    var searchQuery = ''.obs;
  // List of employees
  var employees = <Employee>[
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),
    Employee(name: 'Izaz Ahmed', position: 'Operations Manager'),

    // Add more employees as needed
  ].obs;
  List<Employee> get filteredEmployees {
    if (searchQuery.value.isEmpty) return employees;
    final query = searchQuery.value.toLowerCase();
    
    // Match first then append the rest
    final matched = employees.where((e) => e.name.toLowerCase().contains(query)).toList();
    final unmatched = employees.where((e) => !e.name.toLowerCase().contains(query)).toList();

    return [...matched, ...unmatched];
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  // Toggle checkbox for specific employee
  void toggleCheckbox(int index, bool? value) {
    employees[index].isChecked.value = value ?? false;
  }
}
