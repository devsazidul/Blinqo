import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_compare/screen/add_compare.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_services_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/eventCard.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/home_header_section.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventHomeScreen extends StatelessWidget {
  static const String routeName = '/eventHome';

  const EventHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingEventsController controller = Get.put(
      UpcomingEventsController(),
    );

    final ProfileController profileController = Get.find<ProfileController>();
    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: HomeHeaderSection(themeMode: themeMode),

        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
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
                          // Get.to(FeaturedVenuesScreen());

                          Navigator.pushNamed(
                            context,
                            AppRoute.getfeaturedVenuesScreen(),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      _featureVenuesList(context, themeMode, controller),
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
                          Navigator.pushNamed(
                            context,
                            AppRoute.getvenuesNearScreen(),
                          );
                        },
                      ),
                      _buildVenueNearYouList(context, controller),

                      SizedBox(height: 40),
                      _buildTitle(
                        'Additional Services',
                        themeMode,
                        onTap: () {
                          Get.to(EventServicesScreen());
                        },
                      ),
                      _eventServicesList(context, themeMode),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Get.find<UpcomingEventsController>()
                        .isContainerVisible
                        .value
                    ? Positioned(
                      top: 140,
                      right: 0,
                      child: Container(
                        width: 221,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF003366), Color(0xFF729CC7)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.buttonColor2.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 100,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Venues',
                                style: getTextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: List.generate(
                                controller.venues.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          child: ClipOval(
                                            child: Image.asset(
                                              controller
                                                  .venues[index]['imagePath'],
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          controller.venues[index]['name'],
                                          style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap:
                                              () =>
                                                  controller.removeVenue(index),
                                          child: CircleAvatar(
                                            backgroundColor: AppColors.primary
                                                .withValues(alpha: 0.1),
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
                                  );
                                },
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(AddCompare());
                                },
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
                                    SizedBox(width: 8),
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
                            ),
                          ],
                        ),
                      ),
                    )
                    : Container();
              }),
            ],

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

  Widget _featureVenuesList(
    BuildContext context,
    ThemeMode themeMode,
    UpcomingEventsController controller,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(controller.venues.length, (index) {
          var venue = controller.venues[index];

          return Padding(
            padding: EdgeInsets.only(right: 16),
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
  Widget _buildVenueNearYouList(
    BuildContext context,
    UpcomingEventsController controller,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(controller.venues.length, (index) {
          var venue =
              controller.venues[index]; // Get the venue data from the list

          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: FeatureVenues(
              index: index,
              hallName: venue['name'], // Pass the hall name
              location: venue['location'], // Pass the location
              guestCapacity: venue['guestCapacity'], // Pass the guest capacity
              imagePath: venue['imagePath'], // Pass the image path
              rating: venue['rating'], // Pass the rating
            ),
          );
        }),
      ),
    );
  }

  // Event Services
  Widget _eventServicesList(BuildContext context, ThemeMode themeMode) {
    final List<Service> services = [
      Service(imagePath: IconPath.epphotograph, label: 'Photography'),
      Service(imagePath: IconPath.epvideography, label: 'Videography'),
      Service(imagePath: IconPath.epcatering, label: 'Catering'),
      Service(imagePath: IconPath.epdj, label: 'Dj'),
      Service(imagePath: IconPath.epentertainment, label: 'Entertainment'),
      Service(imagePath: IconPath.epgame, label: 'Game'),
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final service = services[index];
          return EventServiceCard(service: service, themeMode: themeMode);
        },
      ),
    );
  }
}
