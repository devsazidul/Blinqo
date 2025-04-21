import 'package:flutter/material.dart';

import '../controllers/even_profile_controller.dart';
import 'event_avater_card.dart';

class EventPreferenceCard extends StatelessWidget {
  const EventPreferenceCard({
    super.key,
    required this.evenProfileController,
    required this.themeMode,
  });
  final EvenProfileController evenProfileController;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Event Preference',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: evenProfileController.eventPreferences.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return EventAvaterCard(
              evenProfileController: evenProfileController,
              index: index,
              themeMode: themeMode,
            );
          },
        ),
      ],
    );
  }
}
