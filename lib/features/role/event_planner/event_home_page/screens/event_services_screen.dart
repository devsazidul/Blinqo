import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventServicesScreen extends StatelessWidget {
  EventServicesScreen({super.key});
  final ProfileController themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final List<Service> services = [
      Service(imagePath: IconPath.epphotograph, label: 'Photography'),
      Service(imagePath: IconPath.epvideography, label: 'Videography'),
      Service(imagePath: IconPath.epcatering, label: 'Catering'),
      Service(imagePath: IconPath.epdj, label: 'Dj'),
      Service(imagePath: IconPath.epentertainment, label: 'Entertainment'),
      Service(imagePath: IconPath.epgame, label: 'Game'),
    ];
    debugPrint('screenWidth: $screenWidth');
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return EventServiceCard(service: services[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _buildChildAspectRatio(double screenWidth) {
  //   if (screenWidth <= 360) {
  //     return 0.86;
  //   }
  //   if (screenWidth >= 360 && screenWidth < 448) {
  //     return 0.96;
  //   } else {
  //     return 1.1;
  //   }
  // }
}
