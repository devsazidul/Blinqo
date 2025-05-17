class AllUpComingBooking {
  AllUpComingBooking({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  final List<UpComingBooking> data;
  final String? message;
  final int? statusCode;
  final bool? success;

  factory AllUpComingBooking.fromJson(Map<String, dynamic> json) {
    return AllUpComingBooking(
      data: json["data"] == null
          ? []
          : List<UpComingBooking>.from(json["data"]!.map((x) => UpComingBooking.fromJson(x))),
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

class UpComingBooking {
  UpComingBooking({
    required this.id,
    required this.venueName,
    required this.userName,
    required this.status,
    required this.eventDate,
    required this.totalAmount,
    required this.createdAt,
    required this.startTime,
    required this.endTime,
    required this.venueImage,
    required this.venueId,
    required this.bookedById,
    required this.eventName,
  });

  final String? id;
  final String? venueName;
  final String? userName;
  final String? status;
  final DateTime? eventDate;
  final int? totalAmount;
  final DateTime? createdAt;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? venueImage;
  final String? venueId;
  final String? bookedById;
  final String? eventName;

  factory UpComingBooking.fromJson(Map<String, dynamic> json) {
    return UpComingBooking(
      id: json["id"],
      venueName: json["venueName"],
      userName: json["userName"],
      status: json["status"],
      eventDate: json["eventDate"] == null ? null : DateTime.parse(json["eventDate"]),
      totalAmount: json["totalAmount"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
      endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      venueImage: json["venueImage"],
      venueId: json["venueId"],
      bookedById: json["bookedById"],
      eventName: json["eventName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "venueName": venueName,
        "userName": userName,
        "status": status,
        "eventDate": eventDate?.toIso8601String(),
        "totalAmount": totalAmount,
        "createdAt": createdAt?.toIso8601String(),
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "venueImage": venueImage,
        "venueId": venueId,
        "bookedById": bookedById,
        "eventName": eventName,
      };
}