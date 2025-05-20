import 'package:blinqo/features/role/event_planner/home/controller/ep_service_provider_list_controller.dart';
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
        child: GetBuilder<EpServiceProviderListController>(
          builder: (controller) {
            final workModel = controller.workModel;
            if (workModel == null || workModel.data.isEmpty) {
              return Center(child: Text('No works available'));
            }

            return Column(
              children: [
                for (int i = 0; i < workModel.data.length; i++)
                  GestureDetector(
                    child: EpSpWorksCardWidget(
                      imagePath: workModel.data[i].files.first.path,
                      workName: workModel.data[i].projectTitle,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
