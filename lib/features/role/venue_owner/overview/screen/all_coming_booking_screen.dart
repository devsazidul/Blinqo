import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/all_up_comming_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

/// Screen to display all upcoming bookings for venue owner
class AllUpcomingBookingsScreen extends StatelessWidget {
  AllUpcomingBookingsScreen({super.key});

  // Initialize controllers
  final AllUpcomingBookingsController controller = Get.put(
    AllUpcomingBookingsController(),
  );
  final bool isDarkMode =
      Get.put(VenueOwnerProfileController()).isDarkMode.value;

  // Date formatters for consistent date/time display
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  final DateFormat timeFormat = DateFormat('h:mm a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      // Custom AppBar
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'All Upcoming Bookings',
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? const Color(0xff151515) : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        elevation: 0,
      ),
      // Main body with reactive state management
      body: Obx(() {
        // Show loading indicator while fetching data
        if (controller.isLoading.value) {
          return _buildShimmerLoading();
        }

        final bookings = controller.upcomingBookings.value?.data ?? [];

        // Show empty state when no bookings
        if (bookings.isEmpty) {
          return _buildEmptyState();
        }

        // Show list of bookings
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return _buildBookingCard(booking);
          },
        );
      }),
    );
  }

  // Shimmer loading effect
  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 5, // Show 5 shimmer items
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xff32383D) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isDarkMode
                        ? const Color(0xff32383D)
                        : const Color(0xffEBEBEB),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000).withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Shimmer.fromColors(
              baseColor:
                  isDarkMode ? const Color(0xff424242) : Colors.grey[300]!,
              highlightColor:
                  isDarkMode ? const Color(0xff525252) : Colors.grey[100]!,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Image placeholder
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Title and venue name placeholder
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 14,
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
                        const Spacer(),
                        // Status icon placeholder
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Date and status row
                    Row(
                      children: [
                        // Date placeholder
                        Container(
                          width: 150,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Spacer(),
                        // Status badge placeholder
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget for empty state display
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ImagePath.overviewbox,
            height: Get.height * 0.3,
            width: Get.width * 0.6,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 220,
            child: Text(
              "No upcoming bookings yet.",
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

  // Widget for individual booking card
  Widget _buildBookingCard(dynamic booking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xff32383D) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isDarkMode ? const Color(0xff32383D) : const Color(0xffEBEBEB),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Venue image and basic info
              Row(
                children: [
                  _buildVenueImage(booking.venueImage),
                  const SizedBox(width: 12),
                  _buildEventInfo(booking),
                  const Spacer(),
                  _buildStatusIcon(),
                ],
              ),
              const SizedBox(height: 8),
              // Date, time and status
              Row(
                children: [
                  _buildDateTimeInfo(booking),
                  const Spacer(),
                  _buildStatusBadge(booking.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for venue image
  Widget _buildVenueImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child:
          imageUrl != null && imageUrl.isNotEmpty
              ? CachedNetworkImage(
                imageUrl: imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorWidget:
                    (context, error, stackTrace) => _buildPlaceholder(),
                placeholder:
                    (context, url) => _buildPlaceholder(isLoading: true),
              )
              : _buildPlaceholder(),
    );
  }

  // Placeholder widget for missing or loading images
  Widget _buildPlaceholder({bool isLoading = false}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff424242) : const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child:
          isLoading
              ? const Center(child: SizedBox(width: 24, height: 24))
              : Icon(
                Icons.image_outlined,
                size: 24,
                color:
                    isDarkMode
                        ? const Color(0xff8A8A8A)
                        : const Color(0xff999999),
              ),
    );
  }

  // Widget for event name and venue info
  Widget _buildEventInfo(dynamic booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          booking.eventName ?? 'Unnamed Event',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          booking.venueName ?? 'Unknown Venue',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff999999),
          ),
        ),
      ],
    );
  }

  // Widget for status icon
  Widget _buildStatusIcon() {
    return Image.asset(
      IconPath.check,
      width: 28,
      height: 28,
      color: isDarkMode ? const Color(0xffD4AF37) : const Color(0xff003366),
    );
  }

  // Widget for date and time information
  Widget _buildDateTimeInfo(dynamic booking) {
    return Row(
      children: [
        const Icon(Icons.calendar_month, size: 16, color: Color(0xff8A8A8A)),
        const SizedBox(width: 6),
        Text(
          booking.eventDate != null
              ? dateFormat.format(booking.eventDate!)
              : 'N/A',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color:
                isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff767676),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          booking.startTime != null
              ? timeFormat.format(booking.startTime!)
              : 'N/A',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color:
                isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff767676),
          ),
        ),
      ],
    );
  }

  // Widget for status badge
  Widget _buildStatusBadge(String? status) {
    final isConfirmed = status == "Confirmed";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isConfirmed
                ? const Color(0xff37D459).withValues(alpha: 0.2)
                : const Color(0xffD4AF37).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status ?? 'Unknown',
        style: getTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color:
              isConfirmed ? const Color(0xff37D441) : const Color(0xffD4AF37),
        ),
      ),
    );
  }
}
