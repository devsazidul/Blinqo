
class AllEmployee {
  final List<Employee> employees;

  AllEmployee({required this.employees});

  factory AllEmployee.fromJson(List<dynamic> json) {
    return AllEmployee(
      employees: json.map((e) => Employee.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return employees.map((e) => e.toJson()).toList();
  }
}

class Employee {
  final String? id;
  final String? venueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Venue? venue;
  final List<dynamic>? shifts;

  Employee({
    this.id,
    this.venueId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.venue,
    this.shifts,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      venueId: json['venueId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
      shifts: json['shifts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'venue': venue?.toJson(),
      'shifts': shifts,
    };
  }
}

class Venue {
  final String? id;
  final String? profileId;
  final String? name;
  final String? city;
  final String? area;
  final String? description;
  final int? capacity;
  final List<dynamic>? bookedDates;
  final String? type;
  final String? cateringDescription;
  final String? parkingDescription;
  final String? availabilityDescription;
  final String? extraServiceDescription;
  final int? price;
  final String? bookingType;
  final bool? verified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  Venue({
    this.id,
    this.profileId,
    this.name,
    this.city,
    this.area,
    this.description,
    this.capacity,
    this.bookedDates,
    this.type,
    this.cateringDescription,
    this.parkingDescription,
    this.availabilityDescription,
    this.extraServiceDescription,
    this.price,
    this.bookingType,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      profileId: json['profileId'],
      name: json['name'],
      city: json['city'],
      area: json['area'],
      description: json['description'],
      capacity: json['capacity'],
      bookedDates: json['bookedDates'],
      type: json['type'],
      cateringDescription: json['cateringDescription'],
      parkingDescription: json['parkingDescription'],
      availabilityDescription: json['availabilityDescription'],
      extraServiceDescription: json['extraServiceDescription'],
      price: json['price'],
      bookingType: json['bookingType'],
      verified: json['verified'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'name': name,
      'city': city,
      'area': area,
      'description': description,
      'capacity': capacity,
      'bookedDates': bookedDates,
      'type': type,
      'cateringDescription': cateringDescription,
      'parkingDescription': parkingDescription,
      'availabilityDescription': availabilityDescription,
      'extraServiceDescription': extraServiceDescription,
      'price': price,
      'bookingType': bookingType,
      'verified': verified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'status': status,
    };
  }
}