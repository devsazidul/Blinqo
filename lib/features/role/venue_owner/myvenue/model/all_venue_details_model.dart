class AllVenueDetails {
  AllVenueDetails({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  final List<VenueData> data;
  final String? message;
  final int? statusCode;
  final bool? success;

  factory AllVenueDetails.fromJson(Map<String, dynamic> json){
    return AllVenueDetails(
      data: json["data"] == null ? [] : List<VenueData>.from(json["data"]!.map((x) => VenueData.fromJson(x))),
      message: json["message"],
      statusCode: json["statusCode"],
      success: json["success"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
    "message": message,
    "statusCode": statusCode,
    "success": success,
  };

}

class VenueData {
  VenueData({
    required this.id,
    required this.profileId,
    required this.name,
    required this.city,
    required this.area,
    required this.description,
    required this.capacity,
    required this.bookedDates,
    required this.type,
    required this.cateringDescription,
    required this.parkingDescription,
    required this.availabilityDescription,
    required this.extraServiceDescription,
    required this.price,
    required this.bookingType,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.venueImage,
    required this.averageRating,
  });

  final String? id;
  final String? profileId;
  final String? name;
  final String? city;
  final String? area;
  final dynamic description;
  final int? capacity;
  final List<dynamic> bookedDates;
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
  final VenueImage? venueImage;
  final int? averageRating;

  factory VenueData.fromJson(Map<String, dynamic> json){
    return VenueData(
      id: json["id"],
      profileId: json["profileId"],
      name: json["name"],
      city: json["city"],
      area: json["area"],
      description: json["description"],
      capacity: json["capacity"],
      bookedDates: json["bookedDates"] == null ? [] : List<dynamic>.from(json["bookedDates"]!.map((x) => x)),
      type: json["type"],
      cateringDescription: json["cateringDescription"],
      parkingDescription: json["parkingDescription"],
      availabilityDescription: json["availabilityDescription"],
      extraServiceDescription: json["extraServiceDescription"],
      price: json["price"],
      bookingType: json["bookingType"],
      verified: json["verified"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      venueImage: json["venueImage"] == null ? null : VenueImage.fromJson(json["venueImage"]),
      averageRating: json["averageRating"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "profileId": profileId,
    "name": name,
    "city": city,
    "area": area,
    "description": description,
    "capacity": capacity,
    "bookedDates": bookedDates.map((x) => x).toList(),
    "type": type,
    "cateringDescription": cateringDescription,
    "parkingDescription": parkingDescription,
    "availabilityDescription": availabilityDescription,
    "extraServiceDescription": extraServiceDescription,
    "price": price,
    "bookingType": bookingType,
    "verified": verified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "venueImage": venueImage?.toJson(),
    "averageRating": averageRating,
  };

}

class VenueImage {
  VenueImage({
    required this.path,
  });

  final String? path;

  factory VenueImage.fromJson(Map<String, dynamic> json){
    return VenueImage(
      path: json["path"],
    );
  }

  Map<String, dynamic> toJson() => {
    "path": path,
  };

}
