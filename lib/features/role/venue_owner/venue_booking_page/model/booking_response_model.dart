class BookingResponseModel {
  final BookingData? data;
  final String? message;
  final int? statusCode;
  final bool? success;

  BookingResponseModel({
    this.data,
    this.message,
    this.statusCode,
    this.success,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
      message: json['message'],
      statusCode: json['statusCode'],
      success: json['success'],
    );
  }
}

class BookingData {
  final List<Booking> requestedBookings;
  final List<Booking> pendingBookings;
  final List<Booking> confirmedBookings;

  BookingData({
    required this.requestedBookings,
    required this.pendingBookings,
    required this.confirmedBookings,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      requestedBookings:
          (json['requestedBookings'] as List?)
              ?.map((x) => Booking.fromJson(x))
              .toList() ??
          [],
      pendingBookings:
          (json['pendingBookings'] as List?)
              ?.map((x) => Booking.fromJson(x))
              .toList() ??
          [],
      confirmedBookings:
          (json['confirmedBookings'] as List?)
              ?.map((x) => Booking.fromJson(x))
              .toList() ??
          [],
    );
  }
}

class Booking {
  final String? id;
  final String? bookedById;
  final String? venueId;
  final String? serviceProviderId;
  final String? eventName;
  final String? location;
  final String? plannerName;
  final DateTime? selectedDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? duration;
  final String? bookingType;
  final int? guestNumber;
  final dynamic decoration;
  final List<dynamic> services;
  final String? bookingStatus;
  final int? totalAmount;
  final int? paid;
  final int? due;
  final String? accept;
  final bool? isEventFinished;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? eventTypeId;
  final BookedBy? bookedBy;
  final EventType? eventType;

  Booking({
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
    required this.services,
    this.bookingStatus,
    this.totalAmount,
    this.paid,
    this.due,
    this.accept,
    this.isEventFinished,
    this.createdAt,
    this.updatedAt,
    this.eventTypeId,
    this.bookedBy,
    this.eventType,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      bookedById: json['bookedById'],
      venueId: json['venueId'],
      serviceProviderId: json['serviceProviderId'],
      eventName: json['eventName'],
      location: json['location'],
      plannerName: json['plannerName'],
      selectedDate:
          json['selectedDate'] != null
              ? DateTime.parse(json['selectedDate'])
              : null,
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      duration: json['duration'],
      bookingType: json['bookingType'],
      guestNumber: json['guestNumber'],
      decoration: json['decoration'],
      services: json['services'] ?? [],
      bookingStatus: json['bookingStatus'],
      totalAmount: json['totalAmount'],
      paid: json['paid'],
      due: json['due'],
      accept: json['accept'],
      isEventFinished: json['isEventFinished'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      eventTypeId: json['eventTypeId'],
      bookedBy:
          json['bookedBy'] != null ? BookedBy.fromJson(json['bookedBy']) : null,
      eventType:
          json['EventType'] != null
              ? EventType.fromJson(json['EventType'])
              : null,
    );
  }
}

class BookedBy {
  final String? name;
  final ImageData? image;
  final String? id;

  BookedBy({this.name, this.image, this.id});

  factory BookedBy.fromJson(Map<String, dynamic> json) {
    return BookedBy(
      name: json['name'],
      image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
      id: json['id'],
    );
  }
}

class ImageData {
  final String? id;
  final String? name;
  final String? fileId;
  final String? path;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final String? bucket;
  final String? type;
  final String? venueId;
  final String? venueDecorationId;
  final String? eventPreferenceId;

  ImageData({
    this.id,
    this.name,
    this.fileId,
    this.path,
    this.createdAt,
    this.expiresAt,
    this.bucket,
    this.type,
    this.venueId,
    this.venueDecorationId,
    this.eventPreferenceId,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      name: json['name'],
      fileId: json['fileId'],
      path: json['path'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      bucket: json['bucket'],
      type: json['type'],
      venueId: json['venueId'],
      venueDecorationId: json['venueDecorationId'],
      eventPreferenceId: json['eventPreferenceId'],
    );
  }
}

class EventType {
  final String? id;
  final String? name;

  EventType({this.id, this.name});

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(id: json['id'], name: json['name']);
  }
}
