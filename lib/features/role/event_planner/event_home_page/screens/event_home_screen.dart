import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/featured_venues_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/eventCard.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/home_header_section.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/search_ber.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventHomeScreen extends StatelessWidget {
  const EventHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderSection(),
                SizedBox(height: 32),
                SearchBerSection(searchTEController: searchTEController),
                SizedBox(height: 20),
                EventCard(),
                SizedBox(height: 40),

                _buildTitle(
                  'Featured Venues',
                  onTap: () {
                    Get.to(FeaturedVenuesScreen());
                  },
                ),
                SizedBox(height: 8),
                _featureVenuesList(context),
                SizedBox(height: 40),

                // Upcoming Events
                Text(
                  'Upcoming Events',
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      if (i < 3)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: UpcommingEvents(),
                        ),
                  ],
                ),

                SizedBox(height: 40),
                _buildTitle('Venues Near You'),
                _buildVenueNearYouList(context),

                SizedBox(height: 40),
                _buildTitle('Event Services'),
                _eventServicesList(context),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // title
  Widget _buildTitle(String title, {VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                  color: Color(0xFF444444),
                ),
              ),
              Icon(Icons.trending_flat, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  // Feature Venues
  Widget _featureVenuesList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: FeatureVenues(),
          );
        }),
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
            child: FeatureVenues(),
          );
        }),
      ),
    );

    /*Widget _buildVenueList(context) {
    double screenHeight=MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: screenHeight*0.45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _buildVenueCard(context);
        },
      ),
    );
  }*/

    /*Widget _eventServicesList(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for the horizontal list
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  ImagePath.venuesHall,
                  height: 85,
                  width: 116,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Photography',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }*/

    // Event Services List (Horizontal Scroll)
  }

  // Event Services
  Widget _eventServicesList(BuildContext context) {
    final List<Service> services = [
      Service(imagePath: ImagePath.venuesHall, label: 'Photography'),
      Service(imagePath: ImagePath.venuesHall, label: 'Videography'),
      Service(imagePath: ImagePath.venuesHall, label: 'Entertainment'),
      Service(imagePath: ImagePath.venuesHall, label: 'Decoration'),
      Service(imagePath: ImagePath.venuesHall, label: 'Catering'),
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
