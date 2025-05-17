import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/all_coming_booking_screen.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/all_reviews_venue_screen.dart';
import 'package:blinqo/features/role/venue_owner/overview/model/venue_overview_model.dart'
    as model;
import 'package:blinqo/features/role/venue_owner/overview/widgets/custom_over_appbar.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/revenue_card.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/up_coming_event_widget.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final controller = Get.put(OverviewController());
    final user = EventAuthController.profileInfo;
    final textColor =
        isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333);

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      appBar: ProfileRow(
        imagePath: user?.profile?.image?.path ?? "",
        name: user?.name ?? "Unknown",
        role:
            user?.role.first.replaceAll('_', ' ').toLowerCase().capitalize ??
            "Unknown",
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLoading(isDarkMode);
        }
        final analytics = controller.venueOverView.value?.data?.analytics;
        final upcomingEvents =
            controller.venueOverView.value?.data?.upcomingEvents ?? [];
        final recentReviews =
            controller.venueOverView.value?.data?.recentReviews ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // revenue card
              RevenueCard(
                totalRevenue: analytics?.totalRevenue ?? 0,
                currentMonthRevenue: analytics?.currentMonthRevenue ?? 0,
                growthRate: analytics?.growthRate ?? 0.0,
                pendingBookings: analytics?.totalPendingBookings ?? 0,
              ),
              const SizedBox(height: 25),
              // upcoming bookings
              _buildSectionTitle('Upcoming Bookings', textColor),
              if (upcomingEvents.isNotEmpty)
                _buildExploreAllRow(
                  
                  () => Get.to(() => AllUpcomingBookingsScreen()),
                  textColor,
                ),
              UpComingBooking(),
              const SizedBox(height: 10),
              // add new venue button
              _buildAddNewVenueButton(),
              const SizedBox(height: 40),
              // recent reviews
              _buildSectionTitle('Recent Reviews', textColor),
              if (recentReviews.isNotEmpty)
                _buildExploreAllRow(
                
                  () => Get.to(() => AllReviewsVenueScreen()),
                  textColor,
                ),
              _buildReviewsList(controller, recentReviews, isDarkMode),
              SizedBox(height: Get.height*0.1),
            ],
          ),
        );
      }),
    );
  }

  // shimmer Loading
  Widget _buildShimmerLoading(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          // Revenue card shimmer
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xff32383D) : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? const Color(0xff424242) : Colors.grey[300]!,
              highlightColor: isDarkMode ? const Color(0xff525252) : Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          // Section title shimmer
          Shimmer.fromColors(
            baseColor: isDarkMode ? const Color(0xff424242) : Colors.grey[300]!,
            highlightColor: isDarkMode ? const Color(0xff525252) : Colors.grey[100]!,
            child: Container(
              width: 180,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Upcoming events shimmer
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _buildEventShimmer(isDarkMode),
            ),
          ),
          const SizedBox(height: 40),
          // Reviews section shimmer
          Shimmer.fromColors(
            baseColor: isDarkMode ? const Color(0xff424242) : Colors.grey[300]!,
            highlightColor: isDarkMode ? const Color(0xff525252) : Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Reviews shimmer
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _buildReviewShimmer(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  // shimmer Loading for upcoming events
  Widget _buildEventShimmer(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? const Color(0xff424242) : Colors.grey[300]!,
        highlightColor: isDarkMode ? const Color(0xff525252) : Colors.grey[100]!,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
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
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // shimmer Loading for reviews
    Widget _buildReviewShimmer(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? const Color(0xff424242) : Colors.grey[300]!,
        highlightColor: isDarkMode ? const Color(0xff525252) : Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
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
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // section title
  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: getTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }

  // explore all row
  Widget _buildExploreAllRow(VoidCallback onTap, Color textColor) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Text(
            'Explore All',
            style: getTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
        Icon(Icons.arrow_right_alt, color: textColor, size: 18),
      ],
    );
  }

  // add new venue button
  Widget _buildAddNewVenueButton() {
    return InkWell(
      onTap:
          () => Get.to(
            const VenueSetupScreen(
              venueStatus: 'Create New Venue',
              isEdit: false,
            ),
          ),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff003366),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Venue  ',
              style: getTextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),
            const Icon(Icons.add, size: 20, color: Color(0xffF4F4F4)),
          ],
        ),
      ),
    );
  }

  // reviews list
  Widget _buildReviewsList(
    OverviewController controller,
    List<model.RecentReview> recentReviews,
    bool isDarkMode,
  ) {
    return SizedBox(
      width: double.infinity,
      child:
          recentReviews.isEmpty
              ? _buildNoReviewsWidget(isDarkMode)
              : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recentReviews.length > 2 ? 2 : recentReviews.length,
                // Limit to 2
                itemBuilder: (context, index) {
                  final review = recentReviews[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildReviewItem(review, isDarkMode),
                  );
                },
              ),
    );
  }

  // no reviews widget
  Widget _buildNoReviewsWidget(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(ImagePath.reviewpic, height: 140, width: 188),
          const SizedBox(height: 20),
          SizedBox(
            width: 220,
            child: Text(
              "No reviews have been submitted yet.",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode
                        ? const Color(0xffEBEBEB)
                        : const Color(0xff333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // review item
  Widget _buildReviewItem(model.RecentReview review, bool isDarkMode) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildProfileImage(review.profile?.image?.path, isDarkMode),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.profile?.name ?? 'Anonymous',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode
                            ? const Color(0xffEBEBEB)
                            : const Color(0xff333333),
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < (review.rating?.floor() ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: const Color(0xffF0C020),
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              review.createdAt != null
                  ? dateFormat.format(review.createdAt!)
                  : 'N/A',
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
          review.comment ?? 'No comment',
          maxLines: null,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                isDarkMode ? const Color(0xffA1A1A1) : const Color(0xff5C5C5C),
          ),
        ),
      ],
    );
  }

  // profile image
  Widget _buildProfileImage(String? imagePath, bool isDarkMode) {
    return ClipOval(
      child: imagePath != null && imagePath.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              height: 40,
              width: 40,
              placeholder: (context, url) => _buildImagePlaceholder(isDarkMode),
              errorWidget: (context, error, stackTrace) => _buildImagePlaceholder(isDarkMode),
            )
          : _buildImagePlaceholder(isDarkMode),
    );
  }

  Widget _buildImagePlaceholder(bool isDarkMode) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff424242) : const Color(0xffF5F5F5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: 24,
        color: isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff999999),
      ),
    );
  }
}
