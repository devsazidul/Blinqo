import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/even_profile_controller.dart';

class ProfileSetupGoogleMap extends StatelessWidget {
  ProfileSetupGoogleMap({super.key});

  final evenprofileController = Get.find<EvenProfileController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TextFormField(
          controller: evenprofileController.splocationController,
          onFieldSubmitted: (value) {
            evenprofileController.searchLocation(value);
          },
          decoration: InputDecoration(
            labelText: "Location",
            labelStyle: getTextStyle(
              fontSize: 16,
              color: AppColors.borderColor,
            ),
            hintText: "New York City",
            hintStyle: getTextStyle(fontSize: 14, color: AppColors.textColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),

        // Text for "Select From Map"
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select From Map",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(height: 8),

        // Google Map Widget
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GetBuilder<EvenProfileController>(
                  builder: (_) {
                    return GoogleMap(
                      onMapCreated: evenprofileController.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: evenprofileController.center,
                        zoom: 16.0,
                      ),
                      markers: evenprofileController.mapMarkers,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    // Ensure mapController is initialized before using it
                    evenprofileController.mapController.animateCamera(
                      CameraUpdate.newLatLng(evenprofileController.center),
                    );
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  elevation: 4,
                  child: Image.asset(
                    IconPath.mylocation,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
