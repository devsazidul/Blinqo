import 'package:blinqo/features/role/event_planner/event_home_page/screens/booking_list.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart';
import 'package:blinqo/features/role/event_planner/home/start_booking.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/guest_list_screen.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/invitation_card_screen.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/even_payment_option.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/evetnt_congratulation_screen.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/final_review_booking_datieals.dart';
import 'package:blinqo/features/role/event_planner/review_booking/screen/review_booking.dart';
import 'package:blinqo/features/role/event_planner/review_booking/screen/review_booking_datieals.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BookingNavigator extends StatelessWidget {
  const BookingNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget screens;
        if (settings.name == AppRoute.getstartBooking()) {
          screens = StartBooking();
        } else if (settings.name == AppRoute.getReviewBooking()) {
          screens = ReviewBooking();
        } else if (settings.name == AppRoute.getReviewBookingDetails()) {
          screens = ReviewBookingDetails();
        } else if (settings.name == AppRoute.geteventPaymentOption()) {
          screens = EvenPaymentOption();
        }else if (settings.name == SearchStartBooking.routeName) {
          screens = SearchStartBooking();
        }else if (settings.name == ReviewBooking.routeName) {
          screens = ReviewBooking();
        }else if (settings.name == EventCongratulationScreen.routeName) {
          screens = EventCongratulationScreen();
        }else if (settings.name == FinalReviewBookingDatieals.routeName) {
          screens = FinalReviewBookingDatieals();
        }else if (settings.name == GuestListScreen.routeName) {
          screens = GuestListScreen();
        }else if (settings.name == InvitationCardScreen.routeName) {
          screens = InvitationCardScreen();
        } else {
          screens = BookingList();
        }

        return MaterialPageRoute(builder: (context) => screens);
      },
    );
  }
}
