import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/employee_model.dart';

class ShiftResponse {
  final List<ShiftData> data;
  final String message;
  final int statusCode;
  final bool success;

  ShiftResponse({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  factory ShiftResponse.fromJson(Map<String, dynamic> json) {
    return ShiftResponse(
      data:
          (json['data'] as List)
              .map((item) => ShiftData.fromJson(item))
              .toList(),
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
      success: json['success'] as bool,
    );
  }
}

class ShiftData {
  final String id;
  final String venueId;
  final DateTime startTime;
  final DateTime endTime;
  final int duration;
  final String shiftName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final VenueData venue;
  final List<ShiftEmployee> employee;

  ShiftData({
    required this.id,
    required this.venueId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.shiftName,
    required this.createdAt,
    required this.updatedAt,
    required this.venue,
    required this.employee,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) {
    return ShiftData(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      duration: json['duration'] as int,
      shiftName: json['shiftName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      venue: VenueData.fromJson(json['venue'] as Map<String, dynamic>),
      employee:
          (json['employee'] as List)
              .map((item) => ShiftEmployee.fromJson(item))
              .toList(),
    );
  }
}

class VenueData {
  final String id;
  final String profileId;
  final String name;
  final String city;
  final String area;
  final String? description;
  final int capacity;
  final List<dynamic> bookedDates;
  final String type;
  final String? cateringDescription;
  final String? parkingDescription;
  final String? availabilityDescription;
  final String? extraServiceDescription;
  final int price;
  final String bookingType;
  final bool verified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;

  VenueData({
    required this.id,
    required this.profileId,
    required this.name,
    required this.city,
    required this.area,
    this.description,
    required this.capacity,
    required this.bookedDates,
    required this.type,
    this.cateringDescription,
    this.parkingDescription,
    this.availabilityDescription,
    this.extraServiceDescription,
    required this.price,
    required this.bookingType,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory VenueData.fromJson(Map<String, dynamic> json) {
    return VenueData(
      id: json['id'] as String,
      profileId: json['profileId'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      area: json['area'] as String,
      description: json['description'] as String?,
      capacity: json['capacity'] as int,
      bookedDates: json['bookedDates'] as List<dynamic>,
      type: json['type'] as String,
      cateringDescription: json['cateringDescription'] as String?,
      parkingDescription: json['parkingDescription'] as String?,
      availabilityDescription: json['availabilityDescription'] as String?,
      extraServiceDescription: json['extraServiceDescription'] as String?,
      price: json['price'] as int,
      bookingType: json['bookingType'] as String,
      verified: json['verified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String,
    );
  }
}

class ShiftEmployee {
  final String id;
  final String venueId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShiftEmployee({
    required this.id,
    required this.venueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShiftEmployee.fromJson(Map<String, dynamic> json) {
    return ShiftEmployee(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Convert to Employee model
  Employee toEmployee() {
    return Employee(id: id, name: '$firstName $lastName', position: role);
  }
}
