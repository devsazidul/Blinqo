import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/overview/model/all_up_comming_booking_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// Controller to manage upcoming bookings data and state
class AllUpcomingBookingsController extends GetxController {
  // Initialize logger for debugging
  final _logger = Logger();

  // Observable variables to hold data and loading state
  final Rx<AllUpComingBooking?> upcomingBookings = Rx<AllUpComingBooking?>(
    null,
  );
  final RxBool isLoading = false.obs;

  // Called when controller is initialized
  @override
  void onInit() {
    super.onInit();
    fetchAllUpcomingBookings(); // Load data when screen opens
  }

  /// Fetches all upcoming bookings from the API
  Future<void> fetchAllUpcomingBookings() async {
    isLoading.value = true; // Start loading

    try {
      // Make API call to get upcoming bookings
      final response = await OwnerNetworkCaller().getRequest(
        Url: Urls.getAllUpcomingBookings,
        showLoading: false,
      );

      // Handle API response
      if (response.isSuccess) {
        // Convert JSON response to Dart object and save
        //upcomingBookings.value = AllUpComingBooking.fromJson(response.body);
        // TODO: remove this after api integration
        upcomingBookings.value = AllUpComingBooking.fromJson(mockData);
        _logger.i('All upcoming bookings fetched successfully');
      } else {
        _logger.w('Failed to fetch bookings: ${response.errorMessage}');
        EasyLoading.showError(
          'Failed to fetch bookings: ${response.errorMessage}',
        );
      }
    } catch (e, stackTrace) {
      // Handle any errors during API call
      _logger.e('Error fetching bookings: $e', stackTrace: stackTrace);
    } finally {
      isLoading.value = false; // Stop loading regardless of result
    }
  }
}

final mockData = {
  "data": [
    {
      "id": "booking_001",
      "venueName": "Grand Ballroom",
      "userName": "Sarah Johnson",
      "status": "Confirmed",
      "eventDate": "2025-06-10T00:00:00Z",
      "totalAmount": 5000,
      "createdAt": "2025-05-12T10:00:00Z",
      "startTime": "2025-06-10T18:00:00Z",
      "endTime": "2025-06-10T23:00:00Z",
      "venueImage": "https://example.com/images/venue_grand_ballroom.jpg",
      "venueId": "venue_001",
      "bookedById": "user_101",
      "eventName": "Annual Corporate Gala",
    },
    {
      "id": "booking_002",
      "venueName": "Ocean View Resort",
      "userName": "Ayesha Rahman",
      "status": "Pending",
      "eventDate": "2025-06-15T00:00:00Z",
      "totalAmount": 4000,
      "createdAt": "2025-05-14T08:00:00Z",
      "startTime": "2025-06-15T17:00:00Z",
      "endTime": "2025-06-15T22:00:00Z",
      "venueImage": "https://example.com/images/venue_ocean_view.jpg",
      "venueId": "venue_002",
      "bookedById": "user_102",
      "eventName": "Wedding Reception",
    },
    {
      "id": "booking_003",
      "venueName": "Tech Hub Convention Center",
      "userName": "Michael Lee",
      "status": "Confirmed",
      "eventDate": "2025-06-20T00:00:00Z",
      "totalAmount": 6000,
      "createdAt": "2025-05-10T12:00:00Z",
      "startTime": "2025-06-20T09:00:00Z",
      "endTime": "2025-06-20T17:00:00Z",
      "venueImage": "https://example.com/images/venue_tech_hub.jpg",
      "venueId": "venue_003",
      "bookedById": "user_103",
      "eventName": "Tech Conference",
    },
  ],
  "message": "All upcoming bookings retrieved successfully",
  "statusCode": 200,
  "success": true,
};
