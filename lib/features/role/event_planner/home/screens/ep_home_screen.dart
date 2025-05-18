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
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_additional_service_provider_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_services_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/featured_venues_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/eventCard.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:blinqo/features/role/event_planner/home/wigate/feature_venue.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue_shimmer.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/home_header_section.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
import 'package:blinqo/features/role/event_planner/home/controller/ep_get_all_venues_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
// Flutter imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventHomeScreen extends StatelessWidget {
  static const String routeName = '/ep_home_screen';

  const EventHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeDataController = Get.put(EpGetAllVenuesController());
    final upcomingEventsController = Get.put(UpcomingEventsController());
    final femaleColorController = Get.put(PickColorController());
    final profileController = Get.find<ProfileController>();

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
          child: SingleChildScrollView(
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
                    onTap: () {
                      Get.to(FeaturedVenuesScreen());
                    },
                  ),
                  const SizedBox(height: 8),

                  _buildFeaturedVenuesList(
                    context,
                    themeMode,
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

                  _buildUpComingEventList(upcomingEventsController, themeMode),
                  const SizedBox(height: 40),

                  // Venues Near You Section
                  _buildTitle(
                    'Venues Near You',
                    themeMode,
                    onTap: () => Get.to(() => FeaturedVenuesScreen()),
                  ),

                  _buildFeaturedVenuesList(
                    context,
                    themeMode,
                    homeDataController,
                  ),
                  // _buildVenueNearYouList(
                  //   context,
                  //   homeDataController,
                  //   isFemale,
                  //   femaleColorController,
                  // ),
                  const SizedBox(height: 40),

                  // Additional Services Section
                  _buildTitle(
                    'Additional Services',
                    themeMode,
                    onTap: () => Get.to(EventServicesScreen()),
                  ),
                  _buildServiceProviderList(context, themeMode),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
  Widget _buildFeaturedVenuesList(
    BuildContext context,
    ThemeMode themeMode,
    // UpcomingEventsController controller,
    EpGetAllVenuesController homeDataController,
  ) {
    return GetBuilder<EpGetAllVenuesController>(
      builder: (controller) {
        if (controller.isLoading) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: FeatureVenueShimmer(),
                ),
              ),
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              controller.homeResponseData?.featuredVenues?.length ?? 0,
              (index) {
                var venue = controller.homeResponseData?.featuredVenues?[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: FeatureVenues(index: index, venue: venue),
                );
              },
            ),
          ),
        );
      },
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

  // /// Builds the venues near you horizontal list
  // Widget _buildVenueNearYouList(
  //   BuildContext context,
  //   EpGetAllVenuesController homeDataController,
  //   bool isFemale,
  //   PickColorController femaleColorController,
  // ) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: List.generate(
  //         homeDataController.homeResponseData?.featuredVenues?.length ?? 0,
  //         (index) {
  //           var venue =
  //               homeDataController.homeResponseData?.featuredVenues?[index];
  //           return Padding(
  //             padding: const EdgeInsets.only(right: 16),
  //             child: FeatureVenues(
  //               index: index,
  //               hallName: venue?.name ?? '',
  //               location: venue?.area ?? '',
  //               guestCapacity: venue?.capacity ?? 0,
  //               imagePath: venue?.venueImage?.path ?? '',
  //               rating: index + 1,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  /// Builds the event services horizontal list
  Widget _buildServiceProviderList(BuildContext context, ThemeMode themeMode) {
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
