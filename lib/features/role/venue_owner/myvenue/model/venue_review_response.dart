// Model class for venue review response
class VenueReviewResponse {
  final bool? success;
  final VenueReviewData? data;
  final String? message;
  final int? statusCode;

  VenueReviewResponse({this.success, this.data, this.message, this.statusCode});

  factory VenueReviewResponse.fromJson(Map<String, dynamic> json) {
    return VenueReviewResponse(
      success: json['success'],
      data:
          json['data'] != null ? VenueReviewData.fromJson(json['data']) : null,
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}

class VenueReviewData {
  final ReviewStats? stats;
  final List<Review>? reviews;

  VenueReviewData({this.stats, this.reviews});

  factory VenueReviewData.fromJson(Map<String, dynamic> json) {
    return VenueReviewData(
      stats: json['stats'] != null ? ReviewStats.fromJson(json['stats']) : null,
      reviews:
          json['reviews'] != null
              ? List<Review>.from(
                json['reviews'].map((x) => Review.fromJson(x)),
              )
              : null,
    );
  }
}

class ReviewStats {
  final double? averageRating;
  final int? totalReviews;
  final List<RatingBreakdown>? ratingsBreakdown;

  ReviewStats({this.averageRating, this.totalReviews, this.ratingsBreakdown});

  factory ReviewStats.fromJson(Map<String, dynamic> json) {
    return ReviewStats(
      averageRating: json['averageRating']?.toDouble(),
      totalReviews: json['totalReviews'],
      ratingsBreakdown:
          json['ratingsBreakdown'] != null
              ? List<RatingBreakdown>.from(
                json['ratingsBreakdown'].map(
                  (x) => RatingBreakdown.fromJson(x),
                ),
              )
              : null,
    );
  }
}

class RatingBreakdown {
  final int? rating;
  final int? count;

  RatingBreakdown({this.rating, this.count});

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) {
    return RatingBreakdown(rating: json['rating'], count: json['count']);
  }
}

class Review {
  final String? id;
  final String? venueId;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;
  final String? profileId;
  final Profile? profile;

  Review({
    this.id,
    this.venueId,
    this.rating,
    this.comment,
    this.createdAt,
    this.profileId,
    this.profile,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      venueId: json['venueId'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      profileId: json['profileId'],
      profile:
          json['Profile'] != null ? Profile.fromJson(json['Profile']) : null,
    );
  }
}

class Profile {
  final String? name;
  final ImageData? image;

  Profile({this.name, this.image});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
    );
  }
}

class ImageData {
  final String? path;

  ImageData({this.path});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(path: json['path']);
  }
}
