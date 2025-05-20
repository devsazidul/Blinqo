import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/venue_review_response.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_reviews_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/review_card.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/review_shimmer.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllReviewsScreen extends StatelessWidget {
  final String venueId;
  final ScrollController _scrollController = ScrollController();
  final VenueReviewsController _reviewsController = Get.put(
    VenueReviewsController(),
  );
  final bool isDarkMode =
      Get.put(VenueOwnerProfileController()).isDarkMode.value;

  AllReviewsScreen({Key? key, required this.venueId}) : super(key: key) {
    // Initialize controller and listeners
    _initController();
  }

  void _initController() {
    // Fetch initial reviews
    _reviewsController.fetchVenueReviews(venueId);

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _reviewsController.loadMoreReviews(venueId);
      }
    });

    // Add dispose callback using Get.delete
    ever(_reviewsController.reviews, (_) {});
    Get.delete<VenueReviewsController>(force: true);
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagePath.homenodata,
            height: 250,
            width: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            'No Reviews Available',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Reviews will appear here once customers\nstart sharing their experiences.',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: Image.asset(
            IconPath.arrowLeftAlt,
            width: 24,
            height: 24,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Reviews',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        final stats = _reviewsController.reviewStats.value;
        final reviews = _reviewsController.reviews;
        final isLoading = _reviewsController.isLoading.value;

        if (isLoading && reviews.isEmpty) {
          return const ReviewShimmer();
        }

        if (!isLoading && reviews.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () => _reviewsController.refreshReviews(venueId),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (stats != null) ...[
                    _buildRatingStats(stats),
                    const SizedBox(height: 24),
                  ],
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == reviews.length) {
                        return const ReviewShimmer();
                      }

                      final review = reviews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ReviewCard(
                          image:
                              review.profile?.image?.path ??
                              ImagePath.reviewer1,
                          title: review.profile?.name ?? 'Anonymous',
                          time:
                              review.createdAt != null
                                  ? '${review.createdAt!.day} ${getMonthName(review.createdAt!.month)} ${review.createdAt!.year}'
                                  : 'Unknown',
                          desc: review.comment ?? 'No comment',
                          rating: (review.rating ?? 0).toInt(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRatingStats(ReviewStats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${stats.averageRating?.toStringAsFixed(1) ?? '0.0'}',
                style: getTextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 16,
                        color:
                            index < (stats.averageRating?.floor() ?? 0)
                                ? const Color(0xffF0C020)
                                : Colors.grey,
                      );
                    }),
                  ),
                  Text(
                    '${stats.totalReviews ?? 0} reviews',
                    style: getTextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) {
            final rating = 5 - index;
            final ratingData = stats.ratingsBreakdown?.firstWhere(
              (breakdown) => breakdown.rating == rating,
              orElse: () => RatingBreakdown(rating: rating, count: 0),
            );
            final count = ratingData?.count ?? 0;
            final percentage =
                stats.totalReviews != null && stats.totalReviews! > 0
                    ? (count / stats.totalReviews!) * 100
                    : 0.0;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    '$rating',
                    style: getTextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.star, size: 14, color: const Color(0xffF0C020)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor:
                            isDarkMode ? Colors.white24 : Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xffF0C020),
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '($count)',
                    style: getTextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
