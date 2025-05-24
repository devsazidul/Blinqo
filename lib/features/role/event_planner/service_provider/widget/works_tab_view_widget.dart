import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_get_sp_works_controller.dart';
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
        child: GetBuilder<EpGetSpWorksController>(
          builder: (controller) {
            final workModelList = controller.soWorksModelList;
            if (workModelList == null || workModelList.isEmpty) {
              return Center(child: Text('No works available'));
            }

            return Column(
              children: [
                for (int i = 0; i < workModelList.length; i++)
                  GestureDetector(
                    child: EpSpWorksCardWidget(
                      imagePath: workModelList[i].files?[0].path ?? '',
                      workName: workModelList[i].projectTitle ?? '',
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
