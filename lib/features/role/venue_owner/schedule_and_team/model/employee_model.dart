import 'package:get/get.dart';

class Employee {
  String id;
  String name;
  String position;
  RxBool isChecked;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    bool isChecked = false,
  }) : isChecked = isChecked.obs;
}
