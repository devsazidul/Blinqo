import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/ep_common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_service_provider_type_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/wigate/ep_servcie_provider_type_card.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Main screen for displaying available event planning services
// Uses a 2-column grid layout with pull-to-refresh functionality
// Connects to EpServiceProviderTypeController for real-time updates
class EventServicesScreen extends StatelessWidget {
  EventServicesScreen({super.key});
  // Controller for handling theme preferences (dark/light mode)
  final ProfileController themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final bool isDark = themeController.isDarkMode.value;
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<EpServiceProviderTypeController>()
              .fetchAllServiceProviderTypes();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GetBuilder<EpServiceProviderTypeController>(
            builder: (controller) {
              return GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: .20,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.1,
                ),
                itemCount: controller.serviceTypes.length,
                itemBuilder: (context, index) {
                  // return EventServiceCard(service: controller.serviceTypes[index]);
                  return EpServiceProviderTypeCard(
                    spTypeMode: controller.serviceTypes[index],
                    isDark: isDark,
                  );
                },
              );
            },
          ),
        ),
      ),

      bottomNavigationBar: EpBottomNavBarWidget(),
    );
  }
}
