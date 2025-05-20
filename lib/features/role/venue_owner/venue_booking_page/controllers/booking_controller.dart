import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking_response_model.dart'
    as booking_model;
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Controller to handle the price input and update
class PriceController extends GetxController {
  final RxString price = ''.obs;

  void submitPrice(String newPrice) {
    if (newPrice.isNotEmpty) {
      price.value = newPrice; // Update the price
      Get.back(); // Close the dialog
      Get.snackbar('Success', 'Price set to $newPrice');
    } else {
      Get.snackbar('Error', 'Please enter a price');
    }
  }
}

/// Controller for managing booking data and sorting logic.
class BookingController extends GetxController {
  final isLoading = false.obs;
  final bookingResponse = Rxn<booking_model.BookingResponseModel>();

  // Observable lists for different booking types
  final requestedBookings = <booking_model.Booking>[].obs;
  final pendingBookings = <booking_model.Booking>[].obs;
  final confirmedBookings = <booking_model.Booking>[].obs;

  // Computed property for all bookings
  List<booking_model.Booking> get bookings => [
    ...requestedBookings,
    ...pendingBookings,
    ...confirmedBookings,
  ];

  // Current sorting option
  final currentSortOption = "By Date".obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  // Method to toggle sorting option
  void toggleSortOption() {
    currentSortOption.value =
        currentSortOption.value == "By Date" ? "By Venue" : "By Date";

    // Re-sort the lists based on new option
    _sortBookings(requestedBookings);
    _sortBookings(pendingBookings);
    _sortBookings(confirmedBookings);
  }

  // Helper method to sort bookings
  void _sortBookings(RxList<booking_model.Booking> bookingList) {
    if (currentSortOption.value == "By Date") {
      bookingList.sort(
        (a, b) => (b.selectedDate ?? DateTime(1970)).compareTo(
          a.selectedDate ?? DateTime(1970),
        ),
      );
    } else {
      bookingList.sort((a, b) => (a.venueId ?? '').compareTo(b.venueId ?? ''));
    }
  }

  // Mock data for demo purposes
  Map<String, dynamic> get mockBookingData => {
    "success": true,
    "statusCode": 200,
    "message": "Bookings fetched successfully",
    "data": {
      "requestedBookings": [
        {
          "id": "1",
          "bookedById": "user1",
          "venueId": "venue1",
          "eventName": "Wedding Ceremony",
          "location": "New York",
          "selectedDate": "2024-03-25T10:00:00Z",
          "startTime": "2024-03-25T10:00:00Z",
          "endTime": "2024-03-25T16:00:00Z",
          "bookingStatus": "Booking Requests",
          "guestNumber": 200,
          "totalAmount": 5000,
          "paid": 1000,
          "due": 4000,
          "bookedBy": {"name": "John Doe", "id": "user1"},
        },
        {
          "id": "2",
          "bookedById": "user2",
          "venueId": "venue1",
          "eventName": "Birthday Party",
          "location": "Los Angeles",
          "selectedDate": "2024-03-27T14:00:00Z",
          "startTime": "2024-03-27T14:00:00Z",
          "endTime": "2024-03-27T20:00:00Z",
          "bookingStatus": "Booking Requests",
          "guestNumber": 100,
          "totalAmount": 3000,
          "paid": 1500,
          "due": 1500,
          "bookedBy": {"name": "Jane Smith", "id": "user2"},
        },
      ],
      "pendingBookings": [
        {
          "id": "3",
          "bookedById": "user3",
          "venueId": "venue2",
          "eventName": "Corporate Event",
          "location": "Chicago",
          "selectedDate": "2024-03-26T09:00:00Z",
          "startTime": "2024-03-26T09:00:00Z",
          "endTime": "2024-03-26T17:00:00Z",
          "bookingStatus": "In Progress",
          "guestNumber": 150,
          "totalAmount": 4000,
          "paid": 2000,
          "due": 2000,
          "bookedBy": {"name": "Robert Johnson", "id": "user3"},
        },
      ],
      "confirmedBookings": [
        {
          "id": "4",
          "bookedById": "user4",
          "venueId": "venue3",
          "eventName": "Graduation Party",
          "location": "Miami",
          "selectedDate": "2024-03-24T15:00:00Z",
          "startTime": "2024-03-24T15:00:00Z",
          "endTime": "2024-03-24T21:00:00Z",
          "bookingStatus": "Completed",
          "guestNumber": 80,
          "totalAmount": 2500,
          "paid": 2500,
          "due": 0,
          "bookedBy": {"name": "Mary Williams", "id": "user4"},
        },
      ],
    },
  };

  Future<void> fetchBookings() async {
    try {
      isLoading.value = true;
      final response = await OwnerNetworkCaller().getRequest(
        Url: Urls.getAllBookingsByVenueOwner,
        
      );
      if (response.isSuccess) {
        //TODO: remove this after testing
        // final bookingData = booking_model.BookingResponseModel.fromJson(
        //   response.body,

        final bookingData = booking_model.BookingResponseModel.fromJson(
          mockBookingData,

        );
        bookingResponse.value = bookingData;

        // Update the observable lists
        requestedBookings.value = bookingData.data?.requestedBookings ?? [];
        pendingBookings.value = bookingData.data?.pendingBookings ?? [];
        confirmedBookings.value = bookingData.data?.confirmedBookings ?? [];

        // Sort the lists
        _sortBookings(requestedBookings);
        _sortBookings(pendingBookings);
        _sortBookings(confirmedBookings);
      } else {
        Get.snackbar(
          'Error',
          'An error occurred while fetching bookings',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Method to refresh bookings
  Future<void> refreshBookings() async {
    await fetchBookings();
  }

  // Method to accept a booking
  Future<void> acceptBooking(String bookingId) async {
    // TODO: Implement accept booking API call
  }

  // Method to reject/delete a booking
  Future<void> rejectBooking(String bookingId) async {
    // TODO: Implement reject booking API call
  }

  /// Filters bookings by status and sorts them based on the current sort option.
  List<Booking> getBookingsByStatus(String status) {
    var filtered =
        bookings.where((booking) => booking.bookingStatus == status).toList();

    // Convert booking_model.Booking to Booking
    return filtered
        .map(
          (booking) => Booking(
            id: booking.id ?? '',
            name: booking.eventName ?? '',
            venue: booking.venueId ?? '',
            date: DateFormat(
              'dd MMMM, yyyy',
            ).format(booking.selectedDate ?? DateTime.now()),
            time: DateFormat(
              'HH:mm',
            ).format(booking.startTime ?? DateTime.now()),
            status: booking.bookingStatus ?? '',
          ),
        )
        .toList();
  }

  /// Updates the sorting option and refreshes the bookings list.
  void setSortBy(String value) {
    currentSortOption.value = value;
    requestedBookings.refresh();
    pendingBookings.refresh();
    confirmedBookings.refresh();
  }

}
