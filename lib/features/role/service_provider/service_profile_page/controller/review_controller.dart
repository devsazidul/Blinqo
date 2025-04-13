import 'package:blinqo/features/role/service_provider/service_profile_page/model/review_model.dart';
import 'package:get/get.dart';


class ReviewController extends GetxController {
  var reviews = <Review>[].obs;
  var selectedStarFilter = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Create timestamps for demonstration
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime twoDaysAgo = today.subtract(Duration(days: 2));

    // Sample data with timestamps
    reviews.addAll([
      Review(
        userName: "Floyd Miles",
        rating: 5.0,
        comment:
            "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam, augue etiam onare eu vel utrices pharetra. Velit fringilla tellus justo sed nec praesent quam praesent. Scelerisque venenatis leo nunc convallis vel amet faucibus mittis parturient.",
        timestamp: today.millisecondsSinceEpoch, // Today
      ),
      Review(
        userName: "Floyd Miles",
        rating: 4.0,
        comment:
            "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam, augue etiam onare eu vel utrices pharetra. Velit fringilla tellus justo sed nec praesent quam praesent. Scelerisque venenatis leo nunc convallis vel amet faucibus mittis parturient.",
        timestamp: yesterday.millisecondsSinceEpoch, // Yesterday
      ),
      Review(
        userName: "Floyd Miles",
        rating: 4.0,
        comment:
            "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam, augue etiam onare eu vel utrices pharetra. Velit fringilla tellus justo sed nec praesent quam praesent. Scelerisque venenatis leo nunc convallis vel amet faucibus mittis parturient.",
        timestamp: yesterday.millisecondsSinceEpoch, // Yesterday
      ),
      Review(
        userName: "Floyd Miles",
        rating: 3.0,
        comment:
            "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam, augue etiam onare eu vel utrices pharetra. Velit fringilla tellus justo sed nec praesent quam praesent. Scelerisque venenatis leo nunc convallis vel amet faucibus mittis parturient.",
        timestamp: twoDaysAgo.millisecondsSinceEpoch, // Two days ago
      ),
    ]);
  }

  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    double total = reviews.fold(0, (sum, review) => sum + review.rating);
    return (total / reviews.length).toPrecision(1);
  }

  int get reviewCount => reviews.length;

  Map<int, double> get ratingDistribution {
    Map<int, double> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      int star = review.rating.round();
      distribution[star] = (distribution[star] ?? 0) + 1;
    }
    return distribution.map((key, value) => MapEntry(key, (value / reviews.length) * 100));
  }

  List<Review> get filteredReviews {
    if (selectedStarFilter.value == 0) return reviews;
    return reviews.where((review) => review.rating.round() == selectedStarFilter.value).toList();
  }

  void setStarFilter(int star) {
    if (selectedStarFilter.value == star) {
      selectedStarFilter.value = 0;
    } else {
      selectedStarFilter.value = star;
    }
  }
}