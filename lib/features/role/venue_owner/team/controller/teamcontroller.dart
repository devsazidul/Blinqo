import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamControllerGetx extends GetxController {
  final teamList = <Map<String, String>>[].obs;
  var searchQuery = ''.obs;
  List<Map<String, String>> get filteredTeamList {
    if (searchQuery.value.trim().isEmpty) return teamList;
    final q = searchQuery.value.toLowerCase();
    final matched =
        teamList.where((m) {
          final fullName = '${m['firstName']} ${m['lastName']}'.toLowerCase();
          return fullName.contains(q);
        }).toList();
    final unmatched =
        teamList.where((m) {
          final fullName = '${m['firstName']} ${m['lastName']}'.toLowerCase();
          return !fullName.contains(q);
        }).toList();
    return [...matched, ...unmatched];
  }

  // ➌ Search query আপডেট করার মেথড
  void updateSearch(String val) {
    searchQuery.value = val;
  }

  void addTeamMember({
    required String firstName,
    required String lastName,
    required String role,
  }) {
    teamList.add({'firstName': firstName, 'lastName': lastName, 'role': role});
  }

  void updateTeamMember(
    int index,
    String firstName,
    String lastName,
    String role,
  ) {
    teamList[index] = {
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    };
    update(); // GetX UI রিফ্রেশ করবে
  }

  void addTeamMembercontact(Map<String, String> member) {
    teamList.add(member); // টিম লিস্টে নতুন মেম্বার যোগ
    updateSearch(''); // সার্চ রিফ্রেশ
  }

  void clearTeam() {
    teamList.clear();
  }

  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().obs;
  var containerList = <Map<String, String>>[].obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void loadTestData() {
    containerList.value = [
      {"title": "Shift A", "date": "Sat/Mon/Wed", "employee": "12"},
      {"title": "Shift B", "date": "Tue/Thu/Fri", "employee": "12"},
    ];
  }

  @override
  void onInit() {
    super.onInit();
    loadTestData(); // Auto-load test data
  }

  Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);

  String get duration {
    if (startTime.value != null && endTime.value != null) {
      final start = startTime.value!;
      final end = endTime.value!;

      final startMinutes = start.hour * 60 + start.minute;
      final endMinutes = end.hour * 60 + end.minute;

      final diff = endMinutes - startMinutes;
      if (diff < 0) return "Invalid";

      final hours = diff ~/ 60;
      final minutes = diff % 60;

      return "${hours}h ${minutes}m";
    }
    return "--";
  }

  void pickTime({required bool isStartTime}) async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStartTime) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
    }
  }
}
