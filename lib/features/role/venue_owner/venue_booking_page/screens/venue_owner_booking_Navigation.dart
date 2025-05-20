
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/booking_details_page.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/explore_all_screen.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/venue_booking_page.dart';
import 'package:flutter/material.dart';

class VenueOwnerBooking extends StatelessWidget {
  const VenueOwnerBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        Widget screen;
        if (settings.name == BookingDetailsPage.name) {
          screen = BookingDetailsPage();
        } else if (settings.name == ExploreAllScreen.name) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          screen = ExploreAllScreen(
            title: args['title'],
            bookings: args['bookings'],
            controller: args['controller'],
          );
        } else {
          screen = VenueBookingPage();
        }
        return MaterialPageRoute(builder: (context) => screen);
      },
    );
  }
}
