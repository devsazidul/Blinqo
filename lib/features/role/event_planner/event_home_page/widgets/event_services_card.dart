import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_event_service_details.dart'
    show EpEventServiceDetails;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventServiceCard extends StatelessWidget {
  final Service service;

  const EventServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EpEventServiceDetails(service: service));
      },
      child: Column(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(8),
          //   child: Image.asset(
          //     service.imagePath,
          //     height: 123,
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SizedBox(height: 8),
          Text(
            service.label,
            style: getTextStyle(
              color: AppColors.textColor,
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
