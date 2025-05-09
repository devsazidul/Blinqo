
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueSetupHeader extends StatelessWidget {
  const VenueSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the VenueSetupController
    VenueSetupController controller = Get.put(VenueSetupController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        ClipRRect(
          child: Stack(
            children: [
              Obx(() {
                // Check if a venue image is selected, if not, use the default asset image
                if (controller.venueImage.value != null) {
                  // If an image is selected, show it using Image.file
                  return Image.file(
                    controller.venueImage.value!,
                    width: double.infinity,
                    height: height * 0.35,
                    fit: BoxFit.cover,
                  );
                } else {
                  // If no image is selected, use Image.asset for the default image
                  return Image.asset(
                    ImagePath.venuesHall, // Default asset image path
                    width: double.infinity,
                    height: height * 0.35,
                    fit: BoxFit.cover,
                  );
                }
              }),
              Container(
                width: double.infinity,
                height: height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0xFF161616),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withAlpha(50),
              child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 66,
          left: (width - 120) / 2,
          child: Text(
            'Venue Setup',
            style: getTextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: () async {
              controller.pickImage('venue');
            },
            child: CircleAvatar(
              backgroundColor: Color(0xffD4AF37),
              radius: 18,
              child: Icon(
                Icons.mode_edit_outline_outlined,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
