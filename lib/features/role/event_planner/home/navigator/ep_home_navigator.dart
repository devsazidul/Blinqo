import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_view_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/search_details_screen.dart';
import 'package:blinqo/features/role/event_planner/home/screens/ep_home_screen.dart';
import 'package:blinqo/features/role/event_planner/home/start_booking.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../event_home_page/screens/featured_venues_screen.dart';
import '../../event_home_page/screens/venues_near_screen.dart';

class EventHomeNavigator extends StatelessWidget {
  const EventHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget screens;

        if (settings.name == AppRoute.getsearchDetailsScreen()) {
          screens = SearchDetailsScreen();
        } else if (settings.name == AppRoute.getstartBooking()) {
          screens = StartBooking();
        } else if (settings.name == AppRoute.getfilterDetailsScreen()) {
          screens = FilterDetailsScreen();
        } else if (settings.name == AppRoute.getfilterViewScreen()) {
          screens = FilterViewScreen();
        } else if (settings.name == AppRoute.getfeaturedVenuesScreen()) {
          screens = FeaturedVenuesScreen();
        } else if (settings.name == AppRoute.getvenuesNearScreen()) {
          screens = VenuesNearScreen();
        } else {
          screens = EventHomeScreen();
        }
        return MaterialPageRoute(builder: (context) => screens);
      },
    );
  }
}
