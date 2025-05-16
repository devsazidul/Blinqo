import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_additional_service_provider_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventServicesScreen extends StatelessWidget {
  EventServicesScreen({super.key});
  final ProfileController themeController = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    final services = Get.find<EpAdditionalServiceProviderController>().service.value.value.data.toList();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            backgroundColor: AppColors.textColor.withValues(alpha: 0.15),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.arrow_back, color: AppColors.textColor),

              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          'Additional Services',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: .20,
                crossAxisSpacing: 0,
                childAspectRatio: 1.1,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                // return EventServiceCard(service: services[index]);
                return EventServiceCard(datum: services[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
