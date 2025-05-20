import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpComingBooking extends StatelessWidget {
  UpComingBooking({super.key});

  final OverviewController controller = Get.find<OverviewController>();
  final dateFormat = DateFormat('MMM dd, yyyy');
  final timeFormat = DateFormat('h:mm a');

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final bool isDarkMode =
        Get.find<VenueOwnerProfileController>().isDarkMode.value;

    return Obx(() {
      final upcomingEvents =
          controller.venueOverView.value?.data?.upcomingEvents ?? [];
      return SizedBox(
        height:
            screenHeight < 620 ? screenHeight * 0.550 : screenHeight * 0.420,
        child:
            upcomingEvents.isEmpty
                ? _buildEmptyState(isDarkMode)
                : _buildEventsList(context, upcomingEvents, isDarkMode),
      );
    });
  }

  // Empty state widget
  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            width: 232,
            child: Image.asset(ImagePath.overviewbox),
          ),
          const SizedBox(height: 10),
          Text(
            'It looks like no events have been scheduled yet.',
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
        ],
      ),
    );
  }

  // List of events
  Widget _buildEventsList(
    BuildContext context,
    List<dynamic> events,
    bool isDarkMode,
  ) {
    return Column(
      children: List.generate(
        events.length > 3 ? 3 : events.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildEventCard(context, events[index], isDarkMode),
        ),
      ),
    );
  }

  // Individual event card
  Widget _buildEventCard(BuildContext context, dynamic event, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff32383D) : const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: isDarkMode ? const Color(0xff32383D) : const Color(0xffEBEBEB),
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
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.width * 0.025,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVenueImage(
                  context,
                  event.venue?.venueImage?.path,
                  isDarkMode,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                _buildEventInfo(event, isDarkMode),
                const Spacer(),
                _buildStatusIcon(isDarkMode),
              ],
            ),
            const SizedBox(height: 6),
            _buildDateTimeAndStatus(context, event, isDarkMode),
          ],
        ),
      ),
    );
  }

  // Venue image with placeholder
  Widget _buildVenueImage(
    BuildContext context,
    String? imagePath,
    bool isDarkMode,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDarkMode ? const Color(0xff424242) : const Color(0xffF5F5F5),
      ),
      child:
          imagePath != null && imagePath.isNotEmpty
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => _buildImagePlaceholder(isDarkMode),
                  errorWidget:
                      (context, error, stackTrace) =>
                          _buildImagePlaceholder(isDarkMode),
                ),
              )
              : _buildImagePlaceholder(isDarkMode),
    );
  }

  // Image placeholder
  Widget _buildImagePlaceholder(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDarkMode ? const Color(0xff424242) : const Color(0xffF5F5F5),
      ),
      child: Icon(
        Icons.image_outlined,
        size: 24,
        color: isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff999999),
      ),
    );
  }

  // Event name and venue
  Widget _buildEventInfo(dynamic event, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.eventName ?? 'Unnamed Event',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          event.venue?.name ?? 'Unknown Venue',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff999999),
          ),
        ),
      ],
    );
  }

  // Status icon
  Widget _buildStatusIcon(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isDarkMode ? const Color(0x19D4AF37) : const Color(0xffEBEBEB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          IconPath.arrowUpper,
          height: 20,
          width: 20,
          color: isDarkMode ? const Color(0xffD4AF37) : const Color(0xFF003366),
        ),
      ),
    );
  }

  // Date, time and status
  Widget _buildDateTimeAndStatus(
    BuildContext context,
    dynamic event,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month,
          size: MediaQuery.of(context).size.width * 0.035,
          color: const Color(0xff8A8A8A),
        ),
        const SizedBox(width: 6),
        Text(
          event.selectedDate != null
              ? dateFormat.format(event.selectedDate!)
              : 'N/A',
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color:
                isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff767676),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          event.startTime != null ? timeFormat.format(event.startTime!) : 'N/A',
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color:
                isDarkMode ? const Color(0xff8A8A8A) : const Color(0xff767676),
          ),
        ),
        const Spacer(),
        _buildStatusBadge(context, event),
      ],
    );
  }

  // Status badge
  Widget _buildStatusBadge(BuildContext context, dynamic event) {
    final isConfirmed = event.bookingStatus == "Confirmed";
    return Container(
      height: 22,
      width: MediaQuery.of(context).size.width * 0.17,
      decoration: BoxDecoration(
        color:
            isConfirmed
                ? const Color(0xff37D459).withValues(alpha: 0.2)
                : const Color(0xffD4AF37).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          event.bookingStatus ?? 'Pending',
          style: getTextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color:
                isConfirmed ? const Color(0xff37D441) : const Color(0xffD4AF37),
          ),
        ),
      ),
    );
  }
}
