import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/featured_venues_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/eventCard.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue_shimmer.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/home_header_section.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
import 'package:blinqo/features/role/event_planner/home/controller/ep_get_all_venues_controller.dart';
import 'package:blinqo/features/role/event_planner/home/controller/ep_service_provider_type_controller.dart';
import 'package:blinqo/features/role/event_planner/home/screens/event_services_screen.dart';
import 'package:blinqo/features/role/event_planner/home/wigate/ep_servcie_provider_type_card.dart';
import 'package:blinqo/features/role/event_planner/home/wigate/feature_venue.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
// Flutter imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventHomeScreen extends StatelessWidget {
  static const String routeName = '/ep_home_screen';

  const EventHomeScreen({super.key});

  void _loadData() async {
    await Get.find<EpGetAllVenuesController>().getAllVenues();
    await Get.find<EpServiceProviderTypeController>()
        .fetchAllServiceProviderTypes();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    final homeDataController = Get.put(EpGetAllVenuesController());
    final upcomingEventsController = Get.put(UpcomingEventsController());
    final femaleColorController = Get.put(PickColorController());
    final profileController = Get.find<ProfileController>();

    return Obx(() {
      final bool isDark = profileController.isDarkMode.value;
      final bool isFemale = femaleColorController.isFemale.value;

      return Scaffold(
        backgroundColor: isDark ? Colors.black : AppColors.backgroundColor,
        appBar: HomeHeaderSection(
          isDark: isDark,
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
                  SearchBerSection(isDark: isDark),
                  const SizedBox(height: 20),
                  EventCard(),
                  const SizedBox(height: 40),
                  // Featured Venues Section
                  _buildTitle(
                    'Featured Venues',
                    isDark,
                    onTap: () {
                      Get.to(FeaturedVenuesScreen());
                    },
                  ),
                  const SizedBox(height: 8),

                  _buildFeaturedVenuesList(context, isDark, homeDataController),
                  const SizedBox(height: 40),

                  // Upcoming Events Section
                  Text(
                    'Upcoming Events',
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.backgroundColor : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildUpComingEventList(upcomingEventsController, isDark),
                  const SizedBox(height: 40),

                  // Venues Near You Section
                  _buildTitle(
                    'Venues Near You',
                    isDark,
                    onTap: () => Get.to(() => FeaturedVenuesScreen()),
                  ),

                  _buildFeaturedVenuesList(context, isDark, homeDataController),
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
                    isDark,
                    onTap: () => Get.to(EventServicesScreen()),
                  ),

                  /// Additional Services
                  _buildServiceProviderTypeList(context, isDark),
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
  Widget _buildTitle(String title, bool isDark, {VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF444444),
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
                  color: isDark ? Colors.white : const Color(0xFF444444),
                ),
              ),
              Icon(
                Icons.trending_flat,
                size: 16,
                color: isDark ? Colors.white : const Color(0xFF444444),
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
    bool isDark,
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
    bool isDark,
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
            child: UpComingEvents(
              isDark: isDark,
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
  Widget _buildServiceProviderTypeList(BuildContext context, bool isDark) {
    return SizedBox(
      height: 160,
      child: GetBuilder<EpServiceProviderTypeController>(
        builder: (controller) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.serviceTypes.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return EpServiceProviderTypeCard(
                spTypeMode: controller.serviceTypes[index],
                isDark: isDark,
              );
            },
          );
        },
      ),
    ).marginOnly(top: 10);
  }
}
