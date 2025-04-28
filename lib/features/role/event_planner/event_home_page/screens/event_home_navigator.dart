import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_view_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/search_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart';
import 'package:blinqo/features/role/event_planner/home/start_booking.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/even_payment_option.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/evetnt_congratulation_screen.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/final_review_booking_datieals.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'featured_venues_screen.dart';

class EventHomeNavigator extends StatelessWidget {
  const EventHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget screens;

        if (settings.name == AppRoute.getsearchDetailsScreen()) {
          screens = SearchDetailsScreen();
        }
        else if (settings.name == AppRoute.getstartBooking()) {
          screens = StartBooking();
        }
        else if (settings.name == AppRoute.getfilterDetailsScreen()) {
          screens = FilterDetailsScreen();
        }
        else if (settings.name == AppRoute.getfilterViewScreen()) {
          screens = FilterViewScreen();
        } else if (settings.name == AppRoute.getfeaturedVenuesScreen()) {
          screens = FeaturedVenuesScreen();
        } else {
          screens = EventHomeScreen();
        }
        return MaterialPageRoute(builder: (context) => screens);
      },
    );
  }
}
