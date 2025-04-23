import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_view_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/search_details_screen.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';

class EventHomeNavigator extends StatelessWidget {
  const EventHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget screens;
        if (settings.name == AppRoute.getsearchDetailsScreen()) {
          screens = SearchDetailsScreen();
        } else if (settings.name == AppRoute.getfilterDetailsScreen()) {
          screens = FilterDetailsScreen();
        } else if (settings.name == AppRoute.getfilterViewScreen()) {
          screens = FilterViewScreen();
        } else {
          screens = EventHomeScreen();
        }
        return MaterialPageRoute(builder: (context) => screens);
      },
    );
  }
}
