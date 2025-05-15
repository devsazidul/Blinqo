import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_list_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_post_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/works_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpWorksTabViewWidget extends StatelessWidget {
  const SpWorksTabViewWidget({super.key});

  void getAllWorks() async {
    await Get.find<SpGetAllWorksController>().getAllWorks();
  }

  @override
  Widget build(BuildContext context) {
    final SpGetAllWorksController spGetAllWorksController =
        Get.find<SpGetAllWorksController>();
    getAllWorks();
    print(spGetAllWorksController.works.length);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < spGetAllWorksController.works.length; i++)
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, WorkPostScreen.name),
                child: WorksCardWidget(
                  imagePath:
                      spGetAllWorksController.works[i].files?[0].path ?? "",
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
