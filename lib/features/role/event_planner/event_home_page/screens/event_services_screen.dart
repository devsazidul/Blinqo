import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/event_services_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventServicesScreen extends StatelessWidget {
  const EventServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final List<Service> services = [
      Service(imagePath: ImagePath.venuesHall, label: 'Photography'),
      Service(imagePath: ImagePath.venuesHall, label: 'Videography'),
      Service(imagePath: ImagePath.venuesHall, label: 'Entertainment'),
      Service(imagePath: ImagePath.venuesHall, label: 'Decoration'),
      Service(imagePath: ImagePath.venuesHall, label: 'Catering'),
    ];
    print('screenWidth: $screenWidth');
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: const Color(0xFFD9D9D9),
              child: Image.asset(IconPath.arrowLeftAlt),
            ),
          ),
        ),
        title: Text(
          'Event Services',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: _buildChildAspectRatio(screenWidth),
          ),
          itemBuilder: (context, index) {
            return EventServiceCard(service: services[index]);
          },
        ),
      ),
    );
  }
  _buildChildAspectRatio(double screenWidth) {
    if(screenWidth <= 360) {
      return 0.86;
    } if (screenWidth >= 360 && screenWidth < 448) {
      return 0.96;
    } else {
      return 1.1;
    }
  }
}
