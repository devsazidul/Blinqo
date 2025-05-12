import 'package:blinqo/features/role/event_planner/service_provider/widget/works_card_widget.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpWorksTabViewWidget extends StatelessWidget {
  const EpSpWorksTabViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 3; i++)
              GestureDetector(
                onTap: () => Get.to(() => WorkPostScreen()),
                child: EpSpWorksCardWidget(
                  imagePath: "assets/images/wedding_photography_${i + 1}.jpeg",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
