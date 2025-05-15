import 'dart:developer';

class VenueOverView {
  VenueOverView({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  final Data? data;
  final String? message;
  final int? statusCode;
  final bool? success;

  factory VenueOverView.fromJson(Map<String, dynamic> json) {
    log('Parsing VenueOverView: statusCode = ${json["statusCode"]}');
    return VenueOverView(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
      statusCode: json["statusCode"] is num ? json["statusCode"].toInt() : json["statusCode"],
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
    required this.analytics,
    required this.upcomingEvents,
    required this.recentReviews,
  });

  final Analytics? analytics;
  final List<UpcomingEvent> upcomingEvents;
  final List<RecentReview> recentReviews;

  factory Data.fromJson(Map<String, dynamic> json) {
    log('Parsing Data: upcomingEvents count = ${json["upcomingEvents"]?.length ?? 0}');
    return Data(
      analytics: json["analytics"] == null ? null : Analytics.fromJson(json["analytics"]),
      upcomingEvents: json["upcomingEvents"] == null
          ? []
          : List<UpcomingEvent>.from(json["upcomingEvents"]!.map((x) => UpcomingEvent.fromJson(x))),
      recentReviews: json["recentReviews"] == null
          ? []
          : List<RecentReview>.from(json["recentReviews"]!.map((x) => RecentReview.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "analytics": analytics?.toJson(),
    "upcomingEvents": upcomingEvents.map((x) => x.toJson()).toList(),
    "recentReviews": recentReviews.map((x) => x.toJson()).toList(),
  };
}

class Analytics {
  Analytics({
    required this.totalRevenue,
    required this.currentMonthRevenue,
    required this.previousMonthRevenue,
    required this.growthRate,
    required this.totalPendingBookings,
    required this.totalVenues,
  });

  final int? totalRevenue;
  final int? currentMonthRevenue;
  final int? previousMonthRevenue;
  final double? growthRate; // Changed to double? for numeric percentage
  final int? totalPendingBookings;
  final int? totalVenues;

  factory Analytics.fromJson(Map<String, dynamic> json) {
    log('Parsing Analytics: totalRevenue = ${json["totalRevenue"]}');
    return Analytics(
      totalRevenue: json["totalRevenue"] == null
          ? null
          : (json["totalRevenue"] is num ? json["totalRevenue"].toInt() : json["totalRevenue"]),
      currentMonthRevenue: json["currentMonthRevenue"] == null
          ? null
          : (json["currentMonthRevenue"] is num ? json["currentMonthRevenue"].toInt() : json["currentMonthRevenue"]),
      previousMonthRevenue: json["previousMonthRevenue"] == null
          ? null
          : (json["previousMonthRevenue"] is num ? json["previousMonthRevenue"].toInt() : json["previousMonthRevenue"]),
      growthRate: json["growthRate"] == null
          ? null
          : (json["growthRate"] is num
          ? json["growthRate"].toDouble()
          : (double.tryParse(json["growthRate"].toString()) ?? 0.0)),
      totalPendingBookings: json["totalPendingBookings"] == null
          ? null
          : (json["totalPendingBookings"] is num
          ? json["totalPendingBookings"].toInt()
          : json["totalPendingBookings"]),
      totalVenues: json["totalVenues"] == null
          ? null
          : (json["totalVenues"] is num ? json["totalVenues"].toInt() : json["totalVenues"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "currentMonthRevenue": currentMonthRevenue,
    "previousMonthRevenue": previousMonthRevenue,
    "growthRate": growthRate,
    "totalPendingBookings": totalPendingBookings,
    "totalVenues": totalVenues,
  };
}

class RecentReview {
  RecentReview({
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
  final double? rating; // Changed to double? for decimal ratings (e.g., 4.5)
  final String? comment;
  final DateTime? createdAt;
  final String? profileId;
  final Profile? profile;

  factory RecentReview.fromJson(Map<String, dynamic> json) {
    log('Parsing RecentReview: rating = ${json["rating"]}');
    return RecentReview(
      id: json["id"],
      venueId: json["venueId"],
      rating: json["rating"] == null
          ? null
          : (json["rating"] is num ? json["rating"].toDouble() : null),
      comment: json["comment"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      profileId: json["profileId"],
      profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]), // Fixed key
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
  Profile({
    required this.name,
    required this.image,
  });

  final String? name; // Changed to String? for type safety
  final Image? image;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["name"],
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image?.toJson(),
  };
}

class Image {
  Image({
    required this.path,
  });

  final String? path;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      path: json["path"],
    );
  }

  Map<String, dynamic> toJson() => {
    "path": path,
  };
}

class UpcomingEvent {
  UpcomingEvent({
    required this.id,
    required this.bookedById,
    required this.venueId,
    required this.serviceProviderId,
    required this.eventName,
    required this.location,
    required this.plannerName,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.bookingType,
    required this.guestNumber,
    required this.decoration,
    required this.services,
    required this.bookingStatus,
    required this.totalAmount,
    required this.paid,
    required this.due,
    required this.accept,
    required this.isEventFinished,
    required this.createdAt,
    required this.updatedAt,
    required this.eventTypeId,
    required this.venue,
  });

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
  final List<String> services;
  final String? bookingStatus;
  final int? totalAmount;
  final int? paid;
  final int? due;
  final String? accept;
  final bool? isEventFinished;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? eventTypeId;
  final Venue? venue;

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) {
    log('Parsing UpcomingEvent: eventName = ${json["eventName"]}');
    return UpcomingEvent(
      id: json["id"],
      bookedById: json["bookedById"],
      venueId: json["venueId"],
      serviceProviderId: json["serviceProviderId"],
      eventName: json["eventName"],
      location: json["location"],
      plannerName: json["plannerName"],
      selectedDate: json["selectedDate"] == null ? null : DateTime.parse(json["selectedDate"]),
      startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
      endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      duration: json["duration"] == null
          ? null
          : (json["duration"] is num ? json["duration"].toInt() : json["duration"]),
      bookingType: json["bookingType"],
      guestNumber: json["guestNumber"] == null
          ? null
          : (json["guestNumber"] is num ? json["guestNumber"].toInt() : json["guestNumber"]),
      decoration: json["decoration"],
      services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
      bookingStatus: json["bookingStatus"],
      totalAmount: json["totalAmount"] == null
          ? null
          : (json["totalAmount"] is num ? json["totalAmount"].toInt() : json["totalAmount"]),
      paid: json["paid"] == null ? null : (json["paid"] is num ? json["paid"].toInt() : json["paid"]),
      due: json["due"] == null ? null : (json["due"] is num ? json["due"].toInt() : json["due"]),
      accept: json["accept"],
      isEventFinished: json["isEventFinished"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      eventTypeId: json["eventTypeId"],
      venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
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
    "services": services.map((x) => x).toList(),
    "bookingStatus": bookingStatus,
    "totalAmount": totalAmount,
    "paid": paid,
    "due": due,
    "accept": accept,
    "isEventFinished": isEventFinished,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "eventTypeId": eventTypeId,
    "venue": venue?.toJson(),
  };
}

class Venue {
  Venue({
    required this.name,
    required this.area,
    required this.venueImage,
  });

  final String? name;
  final String? area;
  final Image? venueImage;

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      name: json["name"],
      area: json["area"],
      venueImage: json["venueImage"] == null ? null : Image.fromJson(json["venueImage"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "area": area,
    "venueImage": venueImage?.toJson(),
  };
}