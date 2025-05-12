import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/list_venue.png',
      'title': 'List Your Venue in\nMinutes',
      'subtitle':
          'Showcase your event space with images, amenities, and pricing to attract customers.',
    },
    {
      'image': 'assets/images/booking.png',
      'title': 'Real-Time Booking &\nAvailability',
      'subtitle':
          'Accept or decline bookings, update availability, and manage reservations easily.',
    },
    {
      'image': 'assets/images/visibility.png',
      'title': 'Boost Your Venue’s\nVisibility',
      'subtitle':
          'Get featured, collect reviews, and increase revenue with premium listings and insights.',
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed('/home');
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
