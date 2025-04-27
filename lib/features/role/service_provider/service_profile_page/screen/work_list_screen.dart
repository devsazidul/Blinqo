import 'package:blinqo/features/role/service_provider/service_profile_page/screen/work_post_screen.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/sp_profile_app_bar.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/works_card_widget.dart';
import 'package:flutter/material.dart';

class WorkListScreen extends StatelessWidget {
  const WorkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpProfileAppBar(title: "Works"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < 9; i++)
                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(context, WorkPostScreen.name),
                  child: WorksCardWidget(
                    imagePath:
                        "assets/images/wedding_photography_${(i % 3) + 1}.jpeg",
                  ),
                ),
              SizedBox(height: 16),
              // Add more work cards as needed
              // GestureDetector(
              //   onTap: () {
              //     Get.to(() => WorkListScreen());
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     spacing: 8,
              //     children: [
              //       Text("Explore All"),
              //       Icon(Icons.arrow_right_alt_outlined),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
