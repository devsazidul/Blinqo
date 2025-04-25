import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:get/get.dart';

class EpVenuwDetailsController extends GetxController {
  final List<Map<String, String>> reviews = [
    {
      "userName": "John Doe",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "25 April, 2025",
      "reviewText":
          "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam. Augue etiam ornare eu velit ultrices pharetra.",
      "rating": "4",
    },
    {
      "userName": "Jane Smith",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "26 April, 2025",
      "reviewText":
          "Sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis.",
      "rating": "5",
    },
    {
      "userName": "Mike Johnson",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "27 April, 2025",
      "reviewText":
          "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam.",
      "rating": "3",
    },
    {
      "userName": "Emily Davis",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "28 April, 2025",
      "reviewText":
          "Augue etiam ornare eu velit ultrices pharetra. Velit fringilla tellus justo sed et.",
      "rating": "5",
    },
    {
      "userName": "Chris Lee",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "29 April, 2025",
      "reviewText":
          "Sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis vel.",
      "rating": "2",
    },
    {
      "userName": "Amanda White",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "30 April, 2025",
      "reviewText":
          "Velit fringilla tellus justo sed et praesent quam praesent in. Scelerisque venenatis.",
      "rating": "4",
    },
    {
      "userName": "Sophia Brown",
      "userIcon": IconPath.chatlogo2,
      "reviewDate": "1 May, 2025",
      "reviewText":
          "A great experience, looking forward to coming back again soon!",
      "rating": "5",
    },
  ];

  // TextEditingController splocationController = TextEditingController();
  // GoogleMapController? mapController;
  // final LatLng center = const LatLng(37.7749, -122.4194);
  // Set<Marker> markers = {};
  // Set<Marker> get mapMarkers => markers;
  // var isMapReady = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   initMarkers();
  // }

  // void initMarkers({LatLng? location, String? title}) {
  //   final pos = location ?? center;
  //   markers.clear();
  //   markers.add(
  //     Marker(
  //       markerId: MarkerId('searched_location'),
  //       position: pos,
  //       infoWindow: InfoWindow(
  //         title: title ?? 'Selected Location',
  //         snippet: 'Search result',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ),
  //   );
  //   update();
  // }

  // void onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  //   isMapReady.value = true;
  //   update();
  // }

  // Future<void> searchLocation(String place) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(place);
  //     if (locations.isNotEmpty) {
  //       final loc = locations.first;
  //       final target = LatLng(loc.latitude, loc.longitude);
  //       if (mapController != null) {
  //         mapController!.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
  //         initMarkers(location: target, title: place);
  //       } else {
  //         Get.snackbar('Error', 'Map is not ready yet. Please wait.');
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Location not found', 'Try a more specific name');
  //   }
  // }

  // @override
  // void onClose() {
  //   mapController?.dispose();
  //   super.onClose();
  // }
}
