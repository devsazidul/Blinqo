import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueSetupHeader extends StatelessWidget {
  final String title;
  final bool isEdit;
  final String imagePath;

  const VenueSetupHeader({
    super.key,
    required this.title,
    this.isEdit = false,
    this.imagePath = '',
  });

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
              isEdit
                  ? Obx(() {
                    // If user has picked a new image, show it, else show network image
                    if (controller.venueImage.value != null) {
                      return Image.file(
                        controller.venueImage.value!,
                        width: double.infinity,
                        height: height * 0.35,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return CachedNetworkImage(
                        imageUrl: imagePath,
                        width: double.infinity,
                        height: height * 0.35,
                        fit: BoxFit.cover,
                      );
                    }
                  })
                  : Obx(() {
                    return controller.venueImage.value != null
                        ? Image.file(
                          controller.venueImage.value!,
                          width: double.infinity,
                          height: height * 0.35,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          ImagePath.venuesHall, // Default asset image path
                          width: double.infinity,
                          height: height * 0.35,
                          fit: BoxFit.cover,
                        );
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
          top: height * 0.07,
          left: width * 0.05,
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
          top: Get.height * 0.07,
          left: (Get.width - (title.length * 14.0)) / 2,
          child: Text(
            title,
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
