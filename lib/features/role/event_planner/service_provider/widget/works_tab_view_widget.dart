import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_event_service_details_controller.dart';
import 'package:blinqo/features/role/event_planner/service_provider/widget/works_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpWorksTabViewWidget extends StatelessWidget {
  const EpSpWorksTabViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Obx(() {
          final data =
              Get.find<EpEventServiceDetailsController>()
                  .workModel
                  .value
                  .value
                  .data;
          return Column(
            children: [
              for (int i = 0; i < data.length; i++)
                GestureDetector(
                  // onTap:
                  //     () => Get.to(
                  //       () => SpWorkDetailsScreen(spWorksModel: SpWorksModel()),
                  //     ),
                  child: EpSpWorksCardWidget(
                    imagePath: data[i].files.first.path,
                    workName: data[i].projectTitle,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
