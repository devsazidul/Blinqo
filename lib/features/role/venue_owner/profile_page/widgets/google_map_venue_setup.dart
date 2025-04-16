import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapVenueSetup extends StatelessWidget {
  const GoogleMapVenueSetup({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    GoogleMapController? mapController;
    return Container(
      padding: EdgeInsets.all(3),
      width: width * 0.9,
      height: height * 0.26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffABB7C2), width: 1),
      ),
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(23.80732623303042, 90.3686790524852),
              zoom: 14,
            ),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            // Disable default location button
            tiltGesturesEnabled: true,
            scrollGesturesEnabled: true,
            markers: <Marker>{
              Marker(
                markerId: MarkerId('marker_1'),
                position: LatLng(
                  23.80732623303042,
                  90.3686790524852,
                ),
                infoWindow: InfoWindow(
                  title: 'Your Location',
                  snippet: 'This is your location',
                ),
              ),
            },
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                // Handle location button press

                mapController?.animateCamera(
                  duration: Duration(milliseconds: 300),
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        23.80732623303042,
                        90.3686790524852,
                      ),
                      zoom: 14,
                    ),
                  ),
                );
              },
              backgroundColor: Color(0xffFBF7EB),
              child: Icon(
                Icons.my_location,
                color: Color(0xffD4AF37),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
