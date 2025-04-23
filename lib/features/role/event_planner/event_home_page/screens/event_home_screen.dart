import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_services_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/featured_venues_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/venues_near_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/eventCard.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/home_header_section.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';

class EventHomeScreen extends StatelessWidget {
  static const String routeName = '/eventHome'; // Add this line

  const EventHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingEventsController controller = Get.put(
      UpcomingEventsController(),
    );

    final SpProfileController spUserProfileControler =
        Get.find<SpProfileController>();

    return Obx(() {
      // Get the current theme mode (light or dark)
      final themeMode =
          spUserProfileControler.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: HomeHeaderSection(themeMode: themeMode),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),

                    SearchBerSection(themeMode: themeMode),
                    SizedBox(height: 20),
                    EventCard(),
                    SizedBox(height: 40),

                    _buildTitle(
                      'Featured Venues',
                      themeMode,
                      onTap: () {
                        Get.to(FeaturedVenuesScreen());
                      },
                    ),
                    SizedBox(height: 8),
                    _featureVenuesList(context, themeMode),
                    SizedBox(height: 40),

                    // Upcoming Events
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
                    SizedBox(height: 20),
                    _buildUpComingEventList(controller, themeMode),

                    SizedBox(height: 40),
                    _buildTitle(
                      'Venues Near You',
                      themeMode,
                      onTap: () {
                        Get.to(VenuesNearScreen());
                      },
                    ),
                    _buildVenueNearYouList(context),

                    SizedBox(height: 40),
                    _buildTitle(
                      'Event Services',
                      themeMode,
                      onTap: () {
                        Get.to(EventServicesScreen());
                      },
                    ),
                    _eventServicesList(context),
                    SizedBox(height: 20),
                  ],
                );
              }),
            ),
          ),
        ),
      );
    });
  }

  // title
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
                themeMode == ThemeMode.dark ? Colors.white : Color(0xFF444444),
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
                          : Color(0xFF444444),
                ),
              ),
              Icon(
                Icons.trending_flat,
                size: 16,
                color:
                    themeMode == ThemeMode.dark
                        ? Colors.white
                        : Color(0xFF444444),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Feature Venues
  Widget _featureVenuesList(BuildContext context, ThemeMode themeMode) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: FeatureVenues(isColorChinge: true),
          );
        }),
      ),
    );
  }

  // Upcoming Events
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
            ),
          );
        },
      ),
    );
  }

  // Venues Near You
  Widget _buildVenueNearYouList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: FeatureVenues(isColorChinge: false),
          );
        }),
      ),
    );
  }

  // Event Services
  Widget _eventServicesList(BuildContext context) {
    final List<Service> services = [
      Service(imagePath: IconPath.epphotograph, label: 'Photography'),
      Service(imagePath: IconPath.epvideography, label: 'Videography'),
      Service(imagePath: IconPath.epcatering, label: 'Catering'),
      Service(imagePath: IconPath.epdj, label: 'Dj'),
      Service(imagePath: IconPath.epentertainment, label: 'Entertainment'),
      Service(imagePath: IconPath.epgame, label: 'Game'),
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final service = services[index];
          return EventServiceCard(service: service);
        },
      ),
    );
  }
}
