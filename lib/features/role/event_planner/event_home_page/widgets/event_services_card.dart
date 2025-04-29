import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/ep_event_service_details.dart';

class EventServiceCard extends StatelessWidget {
  final Service service;

  final ThemeMode? themeMode;

  const EventServiceCard({super.key, required this.service, this.themeMode});

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(child: Container(color: Colors.amber));
    return GestureDetector(
      onTap: () {
        Get.to(() => EpEventServiceDetails(service: service));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              service.imagePath,
              width: 168,
              height: 123,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            service.label,
            style: GoogleFonts.poppins(
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.backgroundColor
                      : AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Model for a service
class Service {
  final String imagePath;
  final String label;

  Service({required this.imagePath, required this.label});
}
