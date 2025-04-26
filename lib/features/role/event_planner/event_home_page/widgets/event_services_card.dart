import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_event_service_details.dart'
    show EpEventServiceDetails;
import 'package:flutter/material.dart';

class EventServiceCard extends StatelessWidget {
  final Service service;

  const EventServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.red);

    return Container(
      // color: Colors.red,
      child: Image.asset(service.imagePath, fit: BoxFit.cover),
    );
  }
}

// Model for a service
class Service {
  final String imagePath;
  final String label;

  Service({required this.imagePath, required this.label});
}
