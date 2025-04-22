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
    Employee(name: 'Kathryn Murphy', position: 'Operations Manager'),

    // Add more employees as needed
  ].obs;

  // Toggle checkbox for specific employee
  void toggleCheckbox(int index, bool? value) {
    employees[index].isChecked.value = value ?? false;
  }
}
