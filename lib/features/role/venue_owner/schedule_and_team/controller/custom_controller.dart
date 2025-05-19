import 'package:get/get.dart';

class MyDatePickerController extends GetxController {
  final selectedDates = <DateTime>[].obs;

  void toggleDate(DateTime date) {
    if (selectedDates.any((d) => isSameDate(d, date))) {
      selectedDates.removeWhere((d) => isSameDate(d, date));
    } else {
      if (selectedDates.length < 2) {
        selectedDates.add(date);
      } else {
        selectedDates[0] = selectedDates[1];
        selectedDates[1] = date;
      }
    }
  }

  bool isSelected(DateTime date) {
    return selectedDates.any((d) => isSameDate(d, date));
  }

  bool isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
