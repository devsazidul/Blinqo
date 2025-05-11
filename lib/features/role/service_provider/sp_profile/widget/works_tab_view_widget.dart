import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_list_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_post_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/works_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorksTabViewWidget extends StatelessWidget {
  const WorksTabViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 3; i++)
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, WorkPostScreen.name),
                child: WorksCardWidget(
                  imagePath: "assets/images/wedding_photography_${i + 1}.jpeg",
                ),
              ),
            SizedBox(height: 16),
            // Add more work cards as needed
            GestureDetector(
              onTap: () {
                Get.to(() => WorkListScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Text("Explore All"),
                  Icon(Icons.arrow_right_alt_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
