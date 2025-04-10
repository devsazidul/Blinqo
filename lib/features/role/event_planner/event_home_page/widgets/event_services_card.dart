import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventServiceCard extends StatelessWidget {
  final Service service;

  const EventServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            service.imagePath,
            height: 85,
            width: 116,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 6),
        Text(
          service.label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Model for a service
class Service {
  final String imagePath;
  final String label;

  Service({required this.imagePath, required this.label});
}