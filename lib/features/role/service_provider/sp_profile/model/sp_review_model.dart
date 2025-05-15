class SpReviewModel {
  String? id;
  String? venueId;
  int? rating;
  String? comment;
  String? createdAt;
  String? profileId;
  Profile? profile;

  SpReviewModel({
    this.id,
    this.venueId,
    this.rating,
    this.comment,
    this.createdAt,
    this.profileId,
    this.profile,
  });

  factory SpReviewModel.fromJson(Map<String, dynamic> json) {
    return SpReviewModel(
      id: json['id'] ?? '',
      venueId: json['venueId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] ?? '',
      profileId: json['profileId'] ?? '',
      profile: json['profile'] ?? Profile(),
    );
  }
}

class Profile {
  String? name;
  Image? image;

  Profile({this.name, this.image});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(name: json['name'] ?? '', image: json['image'] ?? Image());
  }
}

class Image {
  String? path;

  Image({this.path});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(path: json['path'] ?? '');
  }
}

/*
{
  "reviews": [
    {
      "id": "b0956417-3d64-4c17-8c0a-cea13a62e520",
      "venueId": null,
      "rating": 1,
      "comment": "very bad",
      "createdAt": "2025-05-15T10:19:36.393Z",
      "profileId": "fedb3af2-8e70-40ff-8814-195ba3ab1cad",
      "Profile": {
        "name": "test6",
        "image": {
          "path":
              "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/403ff195-08b6-49ef-9957-8b1376432464612787424837567800.jpg-88e493ac-fc81-494c-9479-9b10d4ad43f1?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T093810Z&X-Amz-Expires=604800&X-Amz-Signature=f65e0606d878ae4a67a671174a9b4e6e8bfe66475e424fa2f7a9a415b3f18c5b&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        },
      },
    },
    {
      "id": "76cd15ff-3221-470b-a819-d41b9ff614d1",
      "venueId": null,
      "rating": 2,
      "comment": "very bad",
      "createdAt": "2025-05-15T10:19:33.003Z",
      "profileId": "fedb3af2-8e70-40ff-8814-195ba3ab1cad",
      "Profile": {
        "name": "test6",
        "image": {
          "path":
              "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/403ff195-08b6-49ef-9957-8b1376432464612787424837567800.jpg-88e493ac-fc81-494c-9479-9b10d4ad43f1?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T093810Z&X-Amz-Expires=604800&X-Amz-Signature=f65e0606d878ae4a67a671174a9b4e6e8bfe66475e424fa2f7a9a415b3f18c5b&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        },
      },
    },
  ],
  "stats": {
    "averageRating": 3.2222222222222223,
    "totalReviews": 9,
    "ratingsBreakdown": [
      {"rating": 5, "count": 2},
      {"rating": 4, "count": 2},
      {"rating": 3, "count": 2},
      {"rating": 2, "count": 2},
      {"rating": 1, "count": 1},
    ],
  },
};
*/
