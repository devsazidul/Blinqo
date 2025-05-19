import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_home_screen_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/venue_details_screen.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/SearchBarWidget.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/venueplaceholder.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/screen/schedule_and_team_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
//------------- Note -------------//
// This screen is used to display the list of venues for a venue owner
// If isTeam is true, the screen will display the list of venues for a team
//--------------------------------//

class VenueHomePage extends StatelessWidget {
  final bool isTeam;
  final TextEditingController searchController = TextEditingController();

  VenueHomePage({super.key, this.isTeam = false});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final AllVenuesDetailsController venueController = Get.put(
      AllVenuesDetailsController(),
    );
    final VenueDetailsController venueDetailsController = Get.put(
      VenueDetailsController(),
    );

    // Bind search bar input to filterVenues
    searchController.addListener(() {
      venueController.filterVenues(searchController.text);
    });

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(isDarkMode),
              const SizedBox(height: 15),
              SearchBarWidget(textcontroller: searchController),
              const SizedBox(height: 12),
              // Venue List
              _buildVenueList(
                screenHeight,
                screenWidth,
                isDarkMode,
                venueController,
                venueDetailsController,
              ),
              const SizedBox(height: 15),
              // Add Venue Button
              if (!isTeam) _buildAddVenueButton(isDarkMode),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title
  Widget _buildHeader(bool isDarkMode) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Venues',
              style: getTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color:
                    isDarkMode
                        ? const Color(0xffEBEBEB)
                        : const Color(0xff333333),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the list of venues with loading state handling
  Widget _buildVenueList(
    double screenHeight,
    double screenWidth,
    bool isDarkMode,
    AllVenuesDetailsController venueController,
    VenueDetailsController venueDetailsController,
  ) {
    return Obx(
      () =>
          venueController.response.value == null
              ? _buildVenueListShimmer(screenHeight, isDarkMode)
              : venueController.filteredVenues.isEmpty
              ? const VenuePlaceholderWidget()
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: venueController.filteredVenues.length,
                itemBuilder: (context, index) {
                  final venue = venueController.filteredVenues[index];
                  return _buildVenueCard(
                    venue,
                    screenHeight,
                    screenWidth,
                    isDarkMode,
                    index,
                    venueController,
                    venueDetailsController,
                  );
                },
              ),
    );
  }

  /// Builds individual venue card
  Widget _buildVenueCard(
    Map<String, String> venue,
    double screenHeight,
    double screenWidth,
    bool isDarkMode,
    int index,
    AllVenuesDetailsController venueController,
    VenueDetailsController venueDetailsController,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xff32383D) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVenueImage(venue, screenHeight, index, venueController),
              const SizedBox(height: 12),
              _buildVenueDetails(
                venue,
                screenHeight,
                screenWidth,
                isDarkMode,
                venueDetailsController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the venue image section with rating and favorite button
  Widget _buildVenueImage(
    Map<String, String> venue,
    double screenHeight,
    int index,
    AllVenuesDetailsController venueController,
  ) {
    return Stack(
      children: [
        // Venue Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: venue["image"]!,
            width: double.infinity,
            height: screenHeight * 0.2,
            fit: BoxFit.cover,
            errorWidget:
                (_, __, ___) => Image.asset(
                  ImagePath.venueview,
                  width: double.infinity,
                  height: screenHeight * 0.2,
                  fit: BoxFit.cover,
                ),
          ),
        ),
        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Rating Badge
        _buildRatingBadge(venue),
        // Favorite Button
        _buildFavoriteButton(index, venueController),
      ],
    );
  }

  /// Builds the rating badge
  Widget _buildRatingBadge(Map<String, String> venue) {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              venue["rating"]!,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.star, size: 12, color: Color(0xffD4AF37)),
          ],
        ),
      ),
    );
  }

  /// Builds the favorite button
  Widget _buildFavoriteButton(
    int index,
    AllVenuesDetailsController venueController,
  ) {
    return Positioned(
      top: 12,
      right: 12,
      child: Obx(() {
        bool isFavorite = venueController.favoriteList[index];
        return CircleAvatar(
          radius: 14,
          backgroundColor: Colors.white,
          child: GestureDetector(
            onTap: () => venueController.toggleFavorite(index),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 14,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),
        );
      }),
    );
  }

  /// Builds the venue details section with title, address, and action button
  Widget _buildVenueDetails(
    Map<String, String> venue,
    double screenHeight,
    double screenWidth,
    bool isDarkMode,
    VenueDetailsController venueDetailsController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          venue['title']!,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Image.asset(
              IconPath.locationOn,
              color: const Color(0xff8A8A8A),
              height: 14,
            ),
            const SizedBox(width: 4),
            Text(
              venue["address"]!,
              style: getTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color(0xff8A8A8A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 1),
        Row(
          children: [
            _buildGuestCapacity(venue),
            const Spacer(),
            _buildActionButton(
              venue,
              screenWidth,
              screenHeight,
              venueDetailsController,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the guest capacity badge
  Widget _buildGuestCapacity(Map<String, String> venue) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xff676767).withAlpha(170),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        venue["guest"]!,
        style: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Builds the action button (Manage Shift/View Details)
  Widget _buildActionButton(
    Map<String, String> venue,
    double screenWidth,
    double screenHeight,
    VenueDetailsController venueDetailsController,
  ) {
    return InkWell(
      onTap: () async {
        if (isTeam) {
          Get.to(
            () => ScheduleAndTeamScreen(
              venueId: venue['id'] ?? '',
            ),
            transition: Transition.rightToLeft,
          );
        } else {
          await venueDetailsController.getVenueDetails(venue['id'] ?? '');
          Get.to(
            () => const VenueDetailsScreen(),
            transition: Transition.rightToLeft,
          );
        }
      },
      child: Container(
        height: screenWidth * 0.12,
        width: screenHeight * 0.25,
        decoration: BoxDecoration(
          color: const Color(0xffD4AF37),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            isTeam ? "Manage Shift" : "View Details",
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the add venue button
  Widget _buildAddVenueButton(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Center(
        child: InkWell(
          onTap: () {
            Get.to(VenueSetupScreen(venueStatus: 'Create New Venue'));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xff003366),
            ),
            child: Center(
              child: Text(
                'Add Venue +',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffF4F4F4),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the shimmer loading effect for venue list
  Widget _buildVenueListShimmer(double screenHeight, bool isDarkMode) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, _) {
        return Shimmer.fromColors(
          baseColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          highlightColor:
              isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xff32383D) : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(width: 120, height: 20, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(width: 80, height: 14, color: Colors.white),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(width: 60, height: 24, color: Colors.white),
                      const Spacer(),
                      Container(width: 90, height: 30, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
