import 'dart:developer'; // For logging

class VenueDetails {
  VenueDetails({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  final Data? data;
  final String? message;
  final int? statusCode;
  final bool? success;

  factory VenueDetails.fromJson(Map<String, dynamic> json) {
    log('Parsing VenueDetails: statusCode = ${json["statusCode"]}');
    return VenueDetails(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
      statusCode:
          json["statusCode"] is num
              ? json["statusCode"].toInt()
              : json["statusCode"],
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

class Data {
  Data({
    required this.venue,
    required this.venueMetrics,
    required this.bookedDate,
    required this.bookingRequest,
    required this.ratting,
  });

  final VenueData? venue;
  final VenueMetrics? venueMetrics;
  final List<BookedDate> bookedDate;
  final List<BookingRequest> bookingRequest;
  final double? ratting;

  factory Data.fromJson(Map<String, dynamic> json) {
    log('Parsing Data: ratting = ${json["ratting"]}');
    return Data(
      venue: json["venue"] == null ? null : VenueData.fromJson(json["venue"]),
      venueMetrics:
          json["venueMetrics"] == null
              ? null
              : VenueMetrics.fromJson(json["venueMetrics"]),
      bookedDate:
          json["bookedDate"] == null
              ? []
              : List<BookedDate>.from(
                json["bookedDate"]!.map((x) => BookedDate.fromJson(x)),
              ),
      bookingRequest:
          json["bookingRequest"] == null
              ? []
              : List<BookingRequest>.from(
                json["bookingRequest"]!.map((x) => BookingRequest.fromJson(x)),
              ),
      ratting:
          json["ratting"] == null
              ? null
              : (json["ratting"] is num ? json["ratting"].toDouble() : null),
    );
  }

  Map<String, dynamic> toJson() => {
    "venue": venue?.toJson(),
    "venueMetrics": venueMetrics?.toJson(),
    "bookedDate": bookedDate.map((x) => x.toJson()).toList(),
    "bookingRequest": bookingRequest.map((x) => x.toJson()).toList(),
    "ratting": ratting,
  };
}

class BookedDate {
  final String? id;
  final DateTime? selectedDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? duration;

  BookedDate({
    this.id,
    this.selectedDate,
    this.startTime,
    this.endTime,
    this.duration,
  });

  factory BookedDate.fromJson(Map<String, dynamic> json) {
    log('Parsing BookedDate: duration = ${json["duration"]}');
    return BookedDate(
      id: json["id"],
      selectedDate:
          json["selectedDate"] == null
              ? null
              : DateTime.parse(json["selectedDate"]),
      startTime:
          json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
      endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      duration:
          json["duration"] == null
              ? null
              : (json["duration"] is num
                  ? json["duration"].toInt()
                  : json["duration"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "selectedDate": selectedDate?.toIso8601String(),
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
    "duration": duration,
  };
}

class BookingRequest {
  final String? id;
  final String? bookedById;
  final String? venueId;
  final dynamic serviceProviderId;
  final String? eventName;
  final String? location;
  final String? plannerName;
  final DateTime? selectedDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? duration;
  final String? bookingType;
  final int? guestNumber;
  final String? decoration;
  final List<String>? services;
  final String? bookingStatus;
  final int? totalAmount;
  final int? paid;
  final int? due;
  final String? accept;
  final bool? isEventFinished;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? eventTypeId;
  final EventType? eventType;

  BookingRequest({
    this.id,
    this.bookedById,
    this.venueId,
    this.serviceProviderId,
    this.eventName,
    this.location,
    this.plannerName,
    this.selectedDate,
    this.startTime,
    this.endTime,
    this.duration,
    this.bookingType,
    this.guestNumber,
    this.decoration,
    this.services,
    this.bookingStatus,
    this.totalAmount,
    this.paid,
    this.due,
    this.accept,
    this.isEventFinished,
    this.createdAt,
    this.updatedAt,
    this.eventTypeId,
    this.eventType,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    log(
      'Parsing BookingRequest: guestNumber = ${json["guestNumber"]}, totalAmount = ${json["totalAmount"]}',
    );
    return BookingRequest(
      id: json["id"],
      bookedById: json["bookedById"],
      venueId: json["venueId"],
      serviceProviderId: json["serviceProviderId"],
      eventName: json["eventName"],
      location: json["location"],
      plannerName: json["plannerName"],
      selectedDate:
          json["selectedDate"] == null
              ? null
              : DateTime.parse(json["selectedDate"]),
      startTime:
          json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
      endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      duration:
          json["duration"] == null
              ? null
              : (json["duration"] is num
                  ? json["duration"].toInt()
                  : json["duration"]),
      bookingType: json["bookingType"],
      guestNumber:
          json["guestNumber"] == null
              ? null
              : (json["guestNumber"] is num
                  ? json["guestNumber"].toInt()
                  : json["guestNumber"]),
      decoration: json["decoration"],
      services:
          json["services"] == null ? [] : List<String>.from(json["services"]!),
      bookingStatus: json["bookingStatus"],
      totalAmount:
          json["totalAmount"] == null
              ? null
              : (json["totalAmount"] is num
                  ? json["totalAmount"].toInt()
                  : json["totalAmount"]),
      paid:
          json["paid"] == null
              ? null
              : (json["paid"] is num ? json["paid"].toInt() : json["paid"]),
      due:
          json["due"] == null
              ? null
              : (json["due"] is num ? json["due"].toInt() : json["due"]),
      accept: json["accept"],
      isEventFinished: json["isEventFinished"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      eventTypeId: json["eventTypeId"],
      eventType:
          json["eventType"] == null
              ? null
              : EventType.fromJson(json["eventType"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookedById": bookedById,
    "venueId": venueId,
    "serviceProviderId": serviceProviderId,
    "eventName": eventName,
    "location": location,
    "plannerName": plannerName,
    "selectedDate": selectedDate?.toIso8601String(),
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
    "duration": duration,
    "bookingType": bookingType,
    "guestNumber": guestNumber,
    "decoration": decoration,
    "services": services,
    "bookingStatus": bookingStatus,
    "totalAmount": totalAmount,
    "paid": paid,
    "due": due,
    "accept": accept,
    "isEventFinished": isEventFinished,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "eventTypeId": eventTypeId,
    "eventType": eventType?.toJson(),
  };
}

class EventType {
  EventType({required this.id, required this.name, required this.avatar});

  final String? id;
  final String? name;
  final ArrangementsImage? avatar;

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
      id: json["id"],
      name: json["name"],
      avatar:
          json["avatar"] == null
              ? null
              : ArrangementsImage.fromJson(json["avatar"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar?.toJson(),
  };
}

class ArrangementsImage {
  ArrangementsImage({
    required this.path,
    this.filename,
    this.originalname,
    this.size,
    this.type,
  });

  final String? path;
  final String? filename;
  final String? originalname;
  final int? size;
  final String? type;

  factory ArrangementsImage.fromJson(Map<String, dynamic> json) {
    return ArrangementsImage(
      path: json["path"],
      filename: json["filename"],
      originalname: json["originalname"],
      size:
          json["size"] == null
              ? null
              : (json["size"] is num ? json["size"].toInt() : json["size"]),
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "path": path,
    "filename": filename,
    "originalname": originalname,
    "size": size,
    "type": type,
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
    required this.reviews,
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
  final ArrangementsImage? arrangementsImage;
  final ArrangementsImage? venueImage;
  final List<Review> reviews;

  factory VenueData.fromJson(Map<String, dynamic> json) {
    log(
      'Parsing VenueData: price = ${json["price"]}, capacity = ${json["capacity"]}',
    );
    return VenueData(
      id: json["id"],
      profileId: json["profileId"],
      name: json["name"],
      city: json["city"],
      area: json["area"],
      description: json["description"],
      capacity:
          json["capacity"] == null
              ? null
              : (json["capacity"] is num
                  ? json["capacity"].toInt()
                  : json["capacity"]),
      bookedDates:
          json["bookedDates"] == null
              ? []
              : List<dynamic>.from(json["bookedDates"]!),
      type: json["type"],
      cateringDescription: json["cateringDescription"],
      parkingDescription: json["parkingDescription"],
      availabilityDescription: json["availabilityDescription"],
      extraServiceDescription: json["extraServiceDescription"],
      price:
          json["price"] == null
              ? null
              : (json["price"] is num ? json["price"].toInt() : json["price"]),
      bookingType: json["bookingType"],
      verified: json["verified"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      amenities:
          json["amenities"] == null
              ? []
              : List<Amenity>.from(
                json["amenities"]!.map((x) => Amenity.fromJson(x)),
              ),
      decoration:
          json["decoration"] == null
              ? null
              : Decoration.fromJson(json["decoration"]),
      arrangementsImage:
          json["arrangementsImage"] == null
              ? null
              : ArrangementsImage.fromJson(json["arrangementsImage"]),
      venueImage:
          json["venueImage"] == null
              ? null
              : ArrangementsImage.fromJson(json["venueImage"]),
      reviews:
          json["reviews"] == null
              ? []
              : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x)),
              ),
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
    "bookedDates": bookedDates,
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
    "amenities": amenities.map((x) => x.toJson()).toList(),
    "decoration": decoration?.toJson(),
    "arrangementsImage": arrangementsImage?.toJson(),
    "venueImage": venueImage?.toJson(),
    "reviews": reviews.map((x) => x.toJson()).toList(),
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

  factory Amenity.fromJson(Map<String, dynamic> json) {
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

class Decoration {
  Decoration({
    this.id,
    this.venueId,
    required this.tableShapes,
    required this.seatingStyles,
    required this.lighting,
    required this.flowerColors,
    required this.flowerTypes,
    required this.fragrances,
  });

  final String? id;
  final String? venueId;
  final List<String> tableShapes;
  final List<String> seatingStyles;
  final List<String> lighting;
  final List<String> flowerColors;
  final List<String> flowerTypes;
  final List<String> fragrances;

  factory Decoration.fromJson(Map<String, dynamic> json) {
    return Decoration(
      id: json["id"],
      venueId: json["venueId"],
      tableShapes:
          json["tableShapes"] == null
              ? []
              : List<String>.from(json["tableShapes"]!),
      seatingStyles:
          json["seatingStyles"] == null
              ? []
              : List<String>.from(json["seatingStyles"]!),
      lighting:
          json["lighting"] == null ? [] : List<String>.from(json["lighting"]!),
      flowerColors:
          json["flowerColors"] == null
              ? []
              : List<String>.from(json["flowerColors"]!),
      flowerTypes:
          json["flowerTypes"] == null
              ? []
              : List<String>.from(json["flowerTypes"]!),
      fragrances:
          json["fragrances"] == null
              ? []
              : List<String>.from(json["fragrances"]!),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "venueId": venueId,
    "tableShapes": tableShapes,
    "seatingStyles": seatingStyles,
    "lighting": lighting,
    "flowerColors": flowerColors,
    "flowerTypes": flowerTypes,
    "fragrances": fragrances,
  };
}

class Review {
  Review({
    required this.id,
    required this.venueId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.profileId,
    required this.profile,
  });

  final String? id;
  final String? venueId;
  final double? rating; // Changed to double? to handle 4.5, 3.5, etc.
  final String? comment;
  final DateTime? createdAt;
  final String? profileId;
  final Profile? profile;

  factory Review.fromJson(Map<String, dynamic> json) {
    log('Parsing Review: rating = ${json["rating"]}');
    return Review(
      id: json["id"],
      venueId: json["venueId"],
      rating:
          json["rating"] == null
              ? null
              : (json["rating"] is num ? json["rating"].toDouble() : null),
      comment: json["comment"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      profileId: json["profileId"],
      profile:
          json["profile"] == null
              ? null
              : Profile.fromJson(json["profile"]), // Fixed key
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "venueId": venueId,
    "rating": rating,
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "profileId": profileId,
    "profile": profile?.toJson(),
  };
}

class Profile {
  Profile({required this.name, required this.image});

  final dynamic name;
  final ArrangementsImage? image;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["name"],
      image:
          json["image"] == null
              ? null
              : ArrangementsImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {"name": name, "image": image?.toJson()};
}

class VenueMetrics {
  VenueMetrics({
    required this.totalRevenue,
    required this.currentMonthRevenue,
    required this.growthRate,
    required this.pendingBookings,
  });

  final int? totalRevenue;
  final int? currentMonthRevenue;
  final double? growthRate;
  final int? pendingBookings;

  factory VenueMetrics.fromJson(Map<String, dynamic> json) {
    log('Parsing VenueMetrics: totalRevenue = ${json["totalRevenue"]}');
    return VenueMetrics(
      totalRevenue:
          json["totalRevenue"] == null
              ? null
              : (json["totalRevenue"] is num
                  ? json["totalRevenue"].toInt()
                  : json["totalRevenue"]),
      currentMonthRevenue:
          json["currentMonthRevenue"] == null
              ? null
              : (json["currentMonthRevenue"] is num
                  ? json["currentMonthRevenue"].toInt()
                  : json["currentMonthRevenue"]),
      growthRate:
          json["growthRate"] == null
              ? null
              : (json["growthRate"] is num
                  ? json["growthRate"].toDouble()
                  : json["growthRate"]),
      pendingBookings:
          json["pendingBookings"] == null
              ? null
              : (json["pendingBookings"] is num
                  ? json["pendingBookings"].toInt()
                  : json["pendingBookings"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "currentMonthRevenue": currentMonthRevenue,
    "growthRate": growthRate,
    "pendingBookings": pendingBookings,
  };
}
