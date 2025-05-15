import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/additional_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/ep_event_service_details.dart';

class EventServiceCard extends StatelessWidget {
  final Datum datum;

  final ThemeMode? themeMode;

  const EventServiceCard({super.key, required this.datum, this.themeMode});

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(child: Container(color: Colors.amber));
    return GestureDetector(
      onTap: () {
        Get.to(() => EpEventServiceDetails(serviceName: datum.name, serviceId: datum.id,));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl:  datum.avatar.path.toString(),
              width: 168,
              height: 123,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) {
                return SizedBox();
              },
            ),
          ),
          Text(
            datum.name,
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
