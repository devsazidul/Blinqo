import 'dart:developer'; // For logging

class AllRecentReview {
  AllRecentReview({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  final List<RecentReview> data;
  final String? message;
  final int? statusCode;
  final bool? success;

  factory AllRecentReview.fromJson(Map<String, dynamic> json) {
    log('Parsing AllRecentReview: data count = ${json["data"]?.length ?? 0}');
    return AllRecentReview(
      data: json["data"] == null
          ? []
          : List<RecentReview>.from(json["data"]!.map((x) => RecentReview.fromJson(x))),
      message: json["message"],
      statusCode: json["statusCode"] is num ? json["statusCode"].toInt() : json["statusCode"],
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

class RecentReview {
  RecentReview({
    required this.id,
    required this.content,
    required this.rating,
    required this.venueName,
    required this.userName,
    required this.createdAt,
    required this.userImage,
  });

  final String? id;
  final String? content;
  final double? rating; // Changed to double? for decimal ratings
  final String? venueName;
  final String? userName;
  final DateTime? createdAt;
  final String? userImage;

  factory RecentReview.fromJson(Map<String, dynamic> json) {
    log('Parsing RecentReview: rating = ${json["rating"]}');
    return RecentReview(
      id: json["id"],
      content: json["content"],
      rating: json["rating"] == null
          ? null
          : (json["rating"] is num ? json["rating"].toDouble() : null),
      venueName: json["venueName"],
      userName: json["userName"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      userImage: json["userImage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "rating": rating,
        "venueName": venueName,
        "userName": userName,
        "createdAt": createdAt?.toIso8601String(),
        "userImage": userImage,
      };
}