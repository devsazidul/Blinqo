// import 'package:blinqo/core/common/widgets/logger_view.dart';
// import 'package:blinqo/core/urls/endpoint.dart';
// import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
// import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
// import 'package:blinqo/features/role/venue_owner/profile_page/Model/amenity_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class AmenitiesController extends GetxController {
//   TextEditingController amenityController = TextEditingController();
//   var availableAmenities = <EventAmenity>[].obs;
//   var selectedAmenities = <EventAmenity>[].obs;
//
//   var isLoading = false.obs;
//   final _logger = createLogger();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _logger.i('AmenitiesController initialized');
//     fetchAmenities();
//   }
//
//   Future<void> createAmenity() async {
//     _logger.i('Creating amenity with name: ${amenityController.text.trim()}');
//     final response = await OwnerNetworkCaller().postRequest(
//       Url: Urls.createAmenity,
//       body: {'name': amenityController.text.trim()},
//     );
//     if (response.isSuccess) {
//       _logger.i('Amenity created successfully: ${response.body}');
//       EasyLoading.showSuccess('Amenity created successfully');
//       amenityController.clear();
//       fetchAmenities(); // Refresh the list after creating a new amenity
//     } else {
//       _logger.w('Failed to create amenity: ${response.errorMessage}');
//       EasyLoading.showError(
//         'Failed to create amenity: ${response.errorMessage}',
//       );
//     }
//   }
//
//   Future<void> fetchAmenities() async {
//     String? authToken = await EvenAuthController.getAuthToken(); // Fetch token
//     if (authToken == null || authToken.isEmpty) {
//       _logger.w('Auth token is missing or invalid.');
//       EasyLoading.showError('Authorization token is missing.');
//       return;
//     }
//
//     _logger.i('Attempting to fetch amenities from ${Urls.eventAmenities}');
//     isLoading.value = true;
//
//     try {
//       // Make the HTTP GET request
//       final response = await http.get(
//         Uri.parse(Urls.eventAmenities),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $authToken',
//         },
//       );
//
//       _logger.i('GET Request URL: ${Urls.eventAmenities}');
//       _logger.i('GET Response: ${response.statusCode}');
//       _logger.i('Response Body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         // Parse the response body
//         List<dynamic> data = jsonDecode(response.body);
//         List<EventAmenity> amenities =
//             data.map((json) => EventAmenity.fromJson(json)).toList();
//
//         // Update the lists based on default selection
//         availableAmenities.value =
//             amenities.where((amenity) => !amenity.defaultSelected).toList();
//         selectedAmenities.value =
//             amenities.where((amenity) => amenity.defaultSelected).toList();
//
//         _logger.i('Amenities fetched successfully: ${amenities.length} items');
//       } else {
//         _logger.w('Failed to fetch amenities: Status ${response.statusCode}');
//         EasyLoading.showError(
//           'Failed to load amenities: Status ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       _logger.e('Error fetching amenities: $e');
//       EasyLoading.showError('Error: $e');
//     } finally {
//       isLoading.value = false;
//       _logger.i('Fetch amenities completed, isLoading: ${isLoading.value}');
//     }
//   }
//
//   void selectAmenity(EventAmenity amenity) {
//     if (availableAmenities.contains(amenity)) {
//       availableAmenities.remove(amenity);
//       selectedAmenities.add(amenity);
//       _logger.d('Selected amenity: ${amenity.name}');
//     }
//     availableAmenities.refresh();
//     selectedAmenities.refresh();
//   }
//
//   void removeAmenity(EventAmenity amenity) {
//     if (selectedAmenities.contains(amenity)) {
//       selectedAmenities.remove(amenity);
//       availableAmenities.add(amenity);
//       _logger.d('Removed amenity: ${amenity.name}');
//     }
//     availableAmenities.refresh();
//     selectedAmenities.refresh();
//   }
// }
