import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_work_list_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_works_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpWorksTabViewWidget extends StatelessWidget {
  const SpWorksTabViewWidget({super.key});

  // void getAllWorks() async {
  //   await Get.find<SpGetAllWorksController>().getAllWorks();
  // }

  @override
  Widget build(BuildContext context) {
    final SpGetAllWorksController spGetAllWorksController =
        Get.find<SpGetAllWorksController>();
    spGetAllWorksController.works.length;
    // getAllWorks();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GetBuilder<SpGetAllWorksController>(
              builder: (controller) {
                // print(controller.works.length);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.works.length,
                  itemBuilder: (context, index) {
                    return index < 3
                        ? SpWorksCardWidget(
                          spWorksModel: controller.works[index],
                        )
                        : const SizedBox.shrink();
                  },
                );
              },
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => SpWorkListScreen());
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
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
