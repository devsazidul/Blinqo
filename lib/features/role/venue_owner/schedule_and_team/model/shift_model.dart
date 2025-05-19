class Shift {
  final String id;
  final String venueId;
  final String shiftName;
  final DateTime startTime;
  final DateTime endTime;
  final List<ShiftEmployee> employees;

  Shift({
    required this.id,
    required this.venueId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.employees,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] ?? '',
      venueId: json['venueId'] ?? '',
      shiftName: json['shiftName'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      employees:
          (json['employees'] as List?)
              ?.map((e) => ShiftEmployee.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'shiftName': shiftName,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'employees': employees.map((e) => e.toJson()).toList(),
    };
  }
}

class ShiftEmployee {
  final String id;
  final String name;
  final String position;

  ShiftEmployee({required this.id, required this.name, required this.position});

  factory ShiftEmployee.fromJson(Map<String, dynamic> json) {
    return ShiftEmployee(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'position': position};
  }
}
