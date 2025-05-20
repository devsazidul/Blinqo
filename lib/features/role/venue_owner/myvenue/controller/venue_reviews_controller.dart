import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/demo_review_data.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/venue_review_response.dart';
import 'package:get/get.dart';

class VenueReviewsController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final reviews = <Review>[].obs;
  final reviewStats = Rxn<ReviewStats>();
  final currentPage = 1.obs;
  final hasMoreData = true.obs;
  final itemsPerPage = 10;

  // Network caller instance
  final NetworkCaller _networkCaller = NetworkCaller();

  // Flag to use demo data (set to false when ready for real API)
  final bool useDemoData = false;

  // Method to fetch reviews with pagination
  Future<void> fetchVenueReviews(String venueId, {bool refresh = false}) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        reviews.clear();
        hasMoreData.value = true;
      }

      if (!hasMoreData.value) return;

      isLoading.value = false;

      if (useDemoData) {
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 800));

        // Get demo data
        final demoResponse = DemoReviewData.getDemoReviewResponse(
          take: itemsPerPage,
          skip: (currentPage.value - 1) * itemsPerPage,
        );

        final reviewResponse = VenueReviewResponse.fromJson(demoResponse);

        if (reviewResponse.data?.reviews != null) {
          if (refresh) {
            reviews.assignAll(reviewResponse.data!.reviews!);
          } else {
            reviews.addAll(reviewResponse.data!.reviews!);
          }

          // Update review stats
          if (reviewResponse.data?.stats != null) {
            reviewStats.value = reviewResponse.data!.stats;
          }

          // Check if there's more data to load
          hasMoreData.value =
              reviewResponse.data!.reviews!.length >= itemsPerPage;

          if (hasMoreData.value) {
            currentPage.value++;
          }
        }
      } else {
        // Real API call implementation
        final url =
            '${Urls.getAllReviewsByVenue(venueId)}?take=$itemsPerPage&skip=${(currentPage.value - 1) * itemsPerPage}';

        final response = await _networkCaller.getRequest(url);

        if (response.isSuccess) {
          final reviewResponse = VenueReviewResponse.fromJson(
            response.responseData,
          );

          if (reviewResponse.data?.reviews != null) {
            if (refresh) {
              reviews.assignAll(reviewResponse.data!.reviews!);
            } else {
              reviews.addAll(reviewResponse.data!.reviews!);
            }

            // Update review stats
            if (reviewResponse.data?.stats != null) {
              reviewStats.value = reviewResponse.data!.stats;
            }

            // Check if there's more data to load
            hasMoreData.value =
                reviewResponse.data!.reviews!.length >= itemsPerPage;

            if (hasMoreData.value) {
              currentPage.value++;
            }
          }
        } else {
          // Handle error case
          print('Error fetching reviews: ${response.errorMessage}');
        }
      }
    } catch (e) {
      // Handle error appropriately
      print('Error fetching reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to refresh reviews
  Future<void> refreshReviews(String venueId) async {
    await fetchVenueReviews(venueId, refresh: true);
  }

  // Method to load more reviews
  Future<void> loadMoreReviews(String venueId) async {
    if (!isLoading.value && hasMoreData.value) {
      await fetchVenueReviews(venueId);
    }
  }
}
