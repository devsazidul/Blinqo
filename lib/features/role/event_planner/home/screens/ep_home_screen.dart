/// Event Home Screen
///
/// This screen serves as the main dashboard for event planners, displaying:
/// - Featured venues
/// - Upcoming events
/// - Venues near the user
/// - Additional services
/// - Search functionality
/// - Venue comparison feature

// Core imports
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
// Feature imports
import 'package:blinqo/features/role/event_planner/event_compare/screen/add_compare.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_additional_service_provider_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_services_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/eventCard.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/home_header_section.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
import 'package:blinqo/features/role/event_planner/home/controller/ep_get_all_venues_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/routes/app_routes.dart';
// Flutter imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventHomeScreen extends StatelessWidget {
  static const String routeName = '/ep_home_screen';

  const EventHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EpGetAllVenuesController homeDataController = Get.put(
      EpGetAllVenuesController(),
    );

    // Initialize controllers
    final UpcomingEventsController controller = Get.put(
      UpcomingEventsController(),
    );
    final femaleColorController = Get.put(PickColorController());
    final ProfileController profileController = Get.find<ProfileController>();

    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      final bool isFemale = femaleColorController.isFemale.value;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: HomeHeaderSection(
          themeMode: themeMode,
          isFemale: isFemale,
          femaleColorController: femaleColorController,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _buildMainContent(
                context,
                controller,
                themeMode,
                isFemale,
                femaleColorController,
                homeDataController,
              ),
              _buildVenueComparisonContainer(controller),
            ],
          ),
        ),
      );
    });
  }

  /// Builds the main scrollable content of the screen
  Widget _buildMainContent(
    BuildContext context,
    UpcomingEventsController controller,
    ThemeMode themeMode,
    bool isFemale,
    PickColorController femaleColorController,
    EpGetAllVenuesController homeDataController,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            SearchBerSection(themeMode: themeMode),
            const SizedBox(height: 20),
            EventCard(),
            const SizedBox(height: 40),

            // Featured Venues Section
            _buildTitle(
              'Featured Venues',
              themeMode,
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppRoute.getfeaturedVenuesScreen(),
                  ),
            ),
            const SizedBox(height: 8),
            _featureVenuesList(
              context,
              themeMode,
              controller,
              homeDataController,
            ),
            const SizedBox(height: 40),

            // Upcoming Events Section
            Text(
              'Upcoming Events',
              style: getTextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.backgroundColor
                        : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildUpComingEventList(controller, themeMode),
            const SizedBox(height: 40),

            // Venues Near You Section
            _buildTitle(
              'Venues Near You',
              themeMode,
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppRoute.getvenuesNearScreen(),
                  ),
            ),
            _buildVenueNearYouList(
              context,
              controller,
              isFemale,
              femaleColorController,
            ),
            const SizedBox(height: 40),

            // Additional Services Section
            _buildTitle(
              'Additional Services',
              themeMode,
              onTap: () => Get.to(EventServicesScreen()),
            ),
            _eventServicesList(context, themeMode),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds the venue comparison container that appears when venues are selected
  Widget _buildVenueComparisonContainer(UpcomingEventsController controller) {
    return Obx(() {
      if (!controller.isContainerVisible.value) return Container();

      return Positioned(
        top: 140,
        right: 0,
        child: Container(
          width: 221,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF003366), Color(0xFF729CC7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.buttonColor2.withValues(alpha: 0.4),
                blurRadius: 100,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVenueComparisonHeader(),
              const SizedBox(height: 8),
              _buildVenueList(controller),
              _buildCompareButton(),
            ],
          ),
        ),
      );
    });
  }

  /// Builds the header section for the venue comparison container
  Widget _buildVenueComparisonHeader() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Venues',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Builds the list of selected venues in the comparison container
  Widget _buildVenueList(UpcomingEventsController controller) {
    return Column(
      children: List.generate(
        controller.venues.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                child: ClipOval(
                  child: Image.asset(
                    controller.venues[index]['imagePath'],
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.venues[index]['name'],
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.removeVenue(index),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  radius: 12,
                  child: ClipOval(
                    child: Image.asset(
                      IconPath.closesmallicon,
                      width: 6,
                      height: 6,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the compare button in the venue comparison container
  Widget _buildCompareButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => Get.to(AddCompare()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Compare Now',
              style: getTextStyle(
                color: AppColors.buttonColor2,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              IconPath.rightarrow,
              width: 16,
              height: 16,
              fit: BoxFit.cover,
              color: AppColors.buttonColor2,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a section title with an "Explore All" button
  Widget _buildTitle(String title, ThemeMode themeMode, {VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color:
                themeMode == ThemeMode.dark
                    ? Colors.white
                    : const Color(0xFF444444),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Explore All',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      themeMode == ThemeMode.dark
                          ? Colors.white
                          : const Color(0xFF444444),
                ),
              ),
              Icon(
                Icons.trending_flat,
                size: 16,
                color:
                    themeMode == ThemeMode.dark
                        ? Colors.white
                        : const Color(0xFF444444),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the featured venues horizontal list
  Widget _featureVenuesList(
    BuildContext context,
    ThemeMode themeMode,
    UpcomingEventsController controller,
    EpGetAllVenuesController homeDataController,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          homeDataController.homeResponseData?.featuredVenues?.length ?? 0,
          (index) {
            var venue =
                homeDataController.homeResponseData?.featuredVenues?[index];
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FeatureVenues(
                index: index,
                hallName: venue?.name ?? '',
                location: venue?.area ?? '',
                guestCapacity: venue?.capacity ?? 0,
                imagePath: venue?.venueImage?.path ?? '',
                rating: 3,
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the upcoming events list
  Widget _buildUpComingEventList(
    UpcomingEventsController controller,
    ThemeMode themeMode,
  ) {
    return Column(
      children: List.generate(
        controller.upcomingEvents.length > 3
            ? 3
            : controller.upcomingEvents.length,
        (index) {
          var event = controller.upcomingEvents[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: UpcommingEvents(
              themeMode: themeMode,
              title: event['title'],
              venue: event['venue'],
              date: event['date'],
              location: event['location'],
              status: event['status'],
              index: index,
            ),
          );
        },
      ),
    );
  }

  /// Builds the venues near you horizontal list
  Widget _buildVenueNearYouList(
    BuildContext context,
    UpcomingEventsController controller,
    bool isFemale,
    PickColorController femaleColorController,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(controller.venues.length, (index) {
          var venue = controller.venues[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FeatureVenues(
              index: index,
              hallName: venue['name'],
              location: venue['location'],
              guestCapacity: venue['guestCapacity'],
              imagePath: venue['imagePath'],
              rating: venue['rating'],
            ),
          );
        }),
      ),
    );
  }

  /// Builds the event services horizontal list
  Widget _eventServicesList(BuildContext context, ThemeMode themeMode) {
    return SizedBox(
      height: 160,
      child: Obx(() {
        final service =
            Get.put(
              EpAdditionalServiceProviderController(),
            ).service.value.value.data;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: service.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return EventServiceCard(
              datum: service[index],
              themeMode: themeMode,
            );
          },
        );
      }),
    ).marginOnly(top: 10);
  }
}
