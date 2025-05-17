import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/all_recent_review_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class AllReviewsVenueScreen extends StatelessWidget {
  const AllReviewsVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllRecentReviewController());
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final ScrollController scrollController = ScrollController();

    // Add listener for infinite scrolling
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !controller.isLoadingMore.value &&
          controller.hasMore.value) {
        controller.fetchAllRecentReviews(isLoadMore: true);
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Reviews'),
        backgroundColor: isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            itemCount: 8, // Show 8 shimmer items
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildShimmerEffect(isDarkMode, context),
            ),
          );
        }

        if (controller.reviews.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset(ImagePath.reviewpic, height: Get.height*0.3, width: Get.width*0.8,),
                  const SizedBox(height: 20),
                  Text(
                    "No reviews have been submitted yet.",
                    textAlign: TextAlign.center,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
                    ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemCount: controller.reviews.length + (controller.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.reviews.length) {
              if (controller.isLoadingMore.value) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[300]!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Loading more reviews...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final review = controller.reviews[index];
            final dateFormat = DateFormat('MMM dd, yyyy');
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: review.userImage != null
                            ? CachedNetworkImage( 
                               imageUrl: review.userImage!,
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                                errorWidget: (context, error, stackTrace) =>
                                    Image.asset(ImagePath.profile, height: 40, width: 40),
                              )
                            : Image.asset(ImagePath.reviewpic, height: 40, width: 40),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.userName ?? 'Anonymous',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
                            ),
                          ),
                          Text(
                            review.venueName ?? 'Unknown Venue',
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff999999),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < (review.rating?.floor() ?? 0) ? Icons.star : Icons.star_border,
                                color: const Color(0xffF0C020),
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        review.createdAt != null ? dateFormat.format(review.createdAt!) : 'N/A',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffC0C0C0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    review.content ?? 'No comment',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? const Color(0xffA1A1A1) : const Color(0xff5C5C5C),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildShimmerEffect(bool isDarkMode, BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 80,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}