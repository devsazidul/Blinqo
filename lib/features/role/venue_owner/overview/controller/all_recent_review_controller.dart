import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/overview/model/all_recent_review_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AllRecentReviewController extends GetxController {
  final _logger = Logger();
  final RxList<RecentReview> reviews =
      <RecentReview>[].obs; // List to store reviews
  final RxBool isLoading = false.obs; // Initial loading state
  final RxBool isLoadingMore = false.obs; // Loading more reviews state
  final RxBool hasMore =
      true.obs; // Flag to check if more reviews are available
  int page = 1; // Current page
  final int limit = 10; // Reviews per page

  @override
  void onInit() {
    super.onInit();
    fetchAllRecentReviews();
  }

  Future<void> fetchAllRecentReviews({bool isLoadMore = false}) async {
    if (isLoadMore && !hasMore.value) {
      _logger.i('No more reviews to load');
      return;
    }

    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
      page = 1; // Reset page for initial fetch
      reviews.clear(); // Clear existing reviews for fresh fetch
    }

    try {
      _logger.i(
        'Fetching reviews from ${Urls.getAllRecentReviews}?page=$page&limit=$limit',
      );
      final response = await OwnerNetworkCaller().getRequest(
        Url: '${Urls.getAllRecentReviews}?page=$page&limit=$limit',
        showLoading: !isLoadMore, // Show loading only for initial fetch
      );

      if (response.isSuccess) {
        _logger.i('Reviews fetched successfully: ${response.body}');
        // final AllRecentReview = AllRecentReview.fromJson(response.body);

        // TODO: remove this after api integration
        final allRecentReviews = AllRecentReview.fromJson(_mockData[0]);
        if (isLoadMore) {
          reviews.addAll(allRecentReviews.data); // Append new reviews
        } else {
          reviews.assignAll(allRecentReviews.data); // Set initial reviews
        }

        // Check if there are more reviews to load
        hasMore.value = allRecentReviews.data.length == limit;
        if (hasMore.value) {
          page++; // Increment page for next fetch
        }

        if (!isLoadMore) {
          _logger.i('Reviews loaded successfully');
        }
      } else {
        _logger.w('Failed to fetch reviews: ${response.errorMessage}');
        _logger.e('Failed to load reviews: ${response.errorMessage}');
      }
    } catch (e, stackTrace) {
      _logger.e('Error fetching reviews: $e', stackTrace: stackTrace);
      EasyLoading.showError('Error: $e');
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }
}

final List<Map<String, dynamic>> _mockData = [
  {
    "data": [
      {
        "id": "review_001",
        "content":
            "The Grand Ballroom was perfect for our gala. The staff was professional, and the ambiance was stunning. Only minor issue was parking availability.",
        "rating": 4.5,
        "venueName": "Grand Ballroom",
        "userName": "Emily Davis",
        "createdAt": "2025-05-08T14:30:00Z",
        "userImage": "https://example.com/images/user_emily.jpg",
      },
      {
        "id": "review_002",
        "content":
            "Ocean View Resort was beautiful, but the event setup took longer than expected. Overall, a great experience with excellent food.",
        "rating": 4.0,
        "venueName": "Ocean View Resort",
        "userName": "Rahul Khan",
        "createdAt": "2025-05-10T09:15:00Z",
        "userImage": "https://example.com/images/user_rahul.jpg",
      },
      {
        "id": "review_003",
        "content":
            "Tech Hub Convention Center exceeded expectations! The AV equipment was top-notch, and the venue was spacious and well-organized.",
        "rating": 5.0,
        "venueName": "Tech Hub Convention Center",
        "userName": "Sophie Chen",
        "createdAt": "2025-05-12T16:45:00Z",
        "userImage": "https://example.com/images/user_sophie.jpg",
      },
    ],
    "message": "All recent reviews retrieved successfully",
    "statusCode": 200,
    "success": true,
  },
];
