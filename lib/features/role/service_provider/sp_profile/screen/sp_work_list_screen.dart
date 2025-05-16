import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_profile_app_bar.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_works_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpWorkListScreen extends StatelessWidget {
  const SpWorkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SpGetAllWorksController>();
    return Scaffold(
      appBar: SpProfileAppBar(title: "Works"),
      body: GetBuilder<SpGetAllWorksController>(
        builder: (controller) {
          // ignore: avoid_print
          print(controller.works.length);
          return ListView.builder(
            itemCount: controller.works.length,
            itemBuilder:
                (context, index) =>
                    SpWorksCardWidget(spWorksModel: controller.works[index]),
          );
        },
      ),
    );
  }
}
