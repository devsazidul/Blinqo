class VenueDetails {
  VenueDetails({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  final VenueData? data;
  final String? message;
  final int? statusCode;
  final bool? success;

  factory VenueDetails.fromJson(Map<String, dynamic> json){
    return VenueDetails(
      data: json["data"] == null ? null : VenueData.fromJson(json["data"]),
      message: json["message"],
      statusCode: json["statusCode"],
      success: json["success"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
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
    required this.amenities,
    required this.decoration,
    required this.arrangementsImage,
    required this.venueImage,
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
  final List<Amenity> amenities;
  final Decoration? decoration;
  final Image? arrangementsImage;
  final Image? venueImage;

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
      amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
      decoration: json["decoration"] == null ? null : Decoration.fromJson(json["decoration"]),
      arrangementsImage: json["arrangementsImage"] == null ? null : Image.fromJson(json["arrangementsImage"]),
      venueImage: json["venueImage"] == null ? null : Image.fromJson(json["venueImage"]),
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
    "amenities": amenities.map((x) => x?.toJson()).toList(),
    "decoration": decoration?.toJson(),
    "arrangementsImage": arrangementsImage?.toJson(),
    "venueImage": venueImage?.toJson(),
  };

}

class Amenity {
  Amenity({
    required this.id,
    required this.name,
    required this.amenityDefault,
    required this.profileId,
  });

  final String? id;
  final String? name;
  final bool? amenityDefault;
  final dynamic profileId;

  factory Amenity.fromJson(Map<String, dynamic> json){
    return Amenity(
      id: json["id"],
      name: json["name"],
      amenityDefault: json["default"],
      profileId: json["profileId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "default": amenityDefault,
    "profileId": profileId,
  };

}

class Image {
  Image({
    required this.path,
  });

  final String? path;

  factory Image.fromJson(Map<String, dynamic> json){
    return Image(
      path: json["path"],
    );
  }

  Map<String, dynamic> toJson() => {
    "path": path,
  };

}

class Decoration {
  Decoration({
    required this.flowerColors,
    required this.flowerTypes,
    required this.fragrances,
    required this.lighting,
    required this.tableShapes,
    required this.seatingStyles,
  });

  final List<String> flowerColors;
  final List<String> flowerTypes;
  final List<String> fragrances;
  final List<String> lighting;
  final List<String> tableShapes;
  final List<String> seatingStyles;

  factory Decoration.fromJson(Map<String, dynamic> json){
    return Decoration(
      flowerColors: json["flowerColors"] == null ? [] : List<String>.from(json["flowerColors"]!.map((x) => x)),
      flowerTypes: json["flowerTypes"] == null ? [] : List<String>.from(json["flowerTypes"]!.map((x) => x)),
      fragrances: json["fragrances"] == null ? [] : List<String>.from(json["fragrances"]!.map((x) => x)),
      lighting: json["lighting"] == null ? [] : List<String>.from(json["lighting"]!.map((x) => x)),
      tableShapes: json["tableShapes"] == null ? [] : List<String>.from(json["tableShapes"]!.map((x) => x)),
      seatingStyles: json["seatingStyles"] == null ? [] : List<String>.from(json["seatingStyles"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "flowerColors": flowerColors.map((x) => x).toList(),
    "flowerTypes": flowerTypes.map((x) => x).toList(),
    "fragrances": fragrances.map((x) => x).toList(),
    "lighting": lighting.map((x) => x).toList(),
    "tableShapes": tableShapes.map((x) => x).toList(),
    "seatingStyles": seatingStyles.map((x) => x).toList(),
  };

}
