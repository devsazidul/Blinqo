class DemoReviewData {
  static Map<String, dynamic> getDemoReviewResponse({
    required int take,
    required int skip,
  }) {
    // Create 20 demo reviews
    final allReviews = List.generate(20, (index) {
      return {
        "id": "review-$index",
        "venueId": "demo-venue-id",
        "rating": 3 + (index % 3), // Ratings between 3-5 for variety
        "comment": "This is a demo review #$index. ${_getRandomComment()}",
        "createdAt":
            DateTime.now()
                .subtract(Duration(days: index * 2))
                .toIso8601String(), // Different dates
        "profileId": "profile-$index",
        "Profile": {
          "name": "Reviewer ${index + 1}",
          "image": {
            "path":
                "https://picsum.photos/200/200?random=$index", // Random demo images
          },
        },
      };
    });

    // Calculate stats
    final ratings = allReviews.map((r) => r['rating'] as int).toList();
    final avgRating = ratings.reduce((a, b) => a + b) / ratings.length;

    // Create rating breakdown
    final breakdown = <Map<String, dynamic>>[];
    for (int i = 1; i <= 5; i++) {
      breakdown.add({
        "rating": i,
        "count": ratings.where((r) => r == i).length,
      });
    }

    // Paginate reviews
    final paginatedReviews = allReviews.skip(skip).take(take).toList();

    return {
      "success": true,
      "data": {
        "stats": {
          "averageRating": avgRating,
          "totalReviews": allReviews.length,
          "ratingsBreakdown": breakdown,
        },
        "reviews": paginatedReviews,
      },
      "message": "Reviews fetched successfully",
      "statusCode": 200,
    };
  }

  static String _getRandomComment() {
    final comments = [
      "The venue was absolutely perfect for our event!",
      "Great ambiance and professional staff.",
      "Excellent facilities and beautiful decoration.",
      "The space was exactly what we needed.",
      "Wonderful experience from start to finish.",
      "The venue exceeded our expectations.",
      "Amazing location and setup.",
      "Perfect for our corporate event.",
      "The lighting and acoustics were fantastic.",
      "Very accommodating and helpful staff.",
    ];
    return comments[DateTime.now().microsecond % comments.length];
  }
}
