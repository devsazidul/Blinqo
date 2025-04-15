import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// A screen that displays all bookings for a specific section.
class ExploreAllScreen extends StatelessWidget {
  static const String name = '/explore_all_screen';
  final String title;
  final List<Booking> bookings;
  final BookingController controller;

  const ExploreAllScreen({
    super.key,
    required this.title,
    required this.bookings,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          title,
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return BookingCard(
              booking: booking,
              controller: controller,
            );
          },
        ),
      ),
    );
  }
}