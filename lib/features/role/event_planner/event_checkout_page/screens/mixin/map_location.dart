import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin MapLocation {
  late GoogleMapController mapController;
  final LatLng center = const LatLng(37.7749, -122.4194);
  Set<Marker> markers = {};
  Set<Marker> get mapMarkers => markers;

  // Initializes markers on the map, with optional location and title
  void initMarkers({LatLng? location, String? title}) {
    final pos = location ?? center;
    markers.clear(); // Clear any existing markers
    markers.add(
      Marker(
        markerId: MarkerId('searched_location'),
        position: pos,
        infoWindow: InfoWindow(
          title: title ?? 'Selected Location',
          snippet: 'Search result',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  // Search location using address, display results and animate map
  Future<void> searchLocation(String place) async {
    try {
      // Use geocoding to find the location by its address
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final target = LatLng(loc.latitude, loc.longitude);
        // Animate map to the found location with zoom level
        mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
        initMarkers(location: target, title: place);
      } else {
        Get.snackbar(
          'No Results',
          'Could not find the location',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Display error message if location lookup fails
      Get.snackbar(
        'Location not found',
        'Try a more specific name',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Called when the map is created, stores the map controller
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
