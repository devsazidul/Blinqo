import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeatingArrangementWidget extends StatelessWidget {
  const SeatingArrangementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    VenueSetupController controller = Get.put(VenueSetupController());
    return Stack(
      children: [
        Obx(() {
          // Check if a selected image exists, if not, use the default asset image
          if (controller.seatArrangementImage.value != null) {
            // If an image is selected, show it using Image.file
            return Image.file(
              controller.seatArrangementImage.value!,
              width: Get.width * 0.9,
              height: Get.height * 0.3,
              fit: BoxFit.cover,
            );
          } else {
            // If no image is selected, use Image.asset for the default image
            return Image.asset(
              ImagePath.seatingArrangement,
              width: Get.width * 0.9,
              height: Get.height * 0.3,
              fit: BoxFit.cover,
            );
          }
        }),
        // Linear gradient overlay
        Container(
          width: Get.width * 0.9,
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00000000), Color(0x00000000), Color(0xFF161616)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Edit button
        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: () async {
              await controller.pickImage('seat');
            },
            child: CircleAvatar(
              backgroundColor: Color(0xffD4AF37),
              radius: 16,
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
