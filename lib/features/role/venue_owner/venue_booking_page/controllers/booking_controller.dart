
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking.dart';
import 'package:get/get.dart';

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
  /// Reactive list of bookings.
  final RxList<Booking> bookings = <Booking>[].obs;

  /// Current sorting option ("By Venue" or "By Date").
  final RxString sortBy = 'By Venue'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBookings();
  }

  /// Loads initial booking data.
  void _loadBookings() {
    bookings.addAll([
     // Booking Requests
      Booking(
        id: '1',
        name: 'Corporate Event',
        venue: 'The Grand Hall',
        date: '15 March, 2025',
        time: '3:00 PM',
        status: 'Booking Requests',
      ),
      Booking(
        id: '2',
        name: 'Wedding Reception',
        venue: 'Sunset Pavilion',
        date: '20 April, 2025',
        time: '6:00 PM',
        status: 'Booking Requests',
      ),
      Booking(
        id: '3',
        name: 'Birthday Party',
        venue: 'Crystal Room',
        date: '10 May, 2025',
        time: '1:00 PM',
        status: 'Booking Requests',
      ),
      // In Progress
      Booking(
        id: '4',
        name: 'Seminar',
        venue: 'Crystal Room',
        date: '25 March, 2025',
        time: '10:00 AM',
        status: 'In Progress',
      ),
      Booking(
        id: '5',
        name: 'Gala Dinner',
        venue: 'The Grand Hall',
        date: '15 April, 2025',
        time: '7:00 PM',
        status: 'In Progress',
      ),
      // Completed
      Booking(
        id: '6',
        name: 'Conference',
        venue: 'Sunset Pavilion',
        date: '05 March, 2025',
        time: '9:00 AM',
        status: 'Completed',
      ),
      Booking(
        id: '7',
        name: 'Workshop',
        venue: 'The Grand Hall',
        date: '10 April, 2025',
        time: '2:00 PM',
        status: 'Completed',
      ),
      Booking(
        id: '8',
        name: 'Charity Event',
        venue: 'Crystal Room',
        date: '30 March, 2025',
        time: '5:00 PM',
        status: 'Completed',
      ),
      Booking(
        id: '9',
        name: 'Charity Event',
        venue: 'Crystal Room',
        date: '30 March, 2025',
        time: '5:00 PM',
        status: 'Completed',
      ),
      Booking(
        id: '10',
        name: 'Charity Event',
        venue: 'Crystal Room',
        date: '30 March, 2025',
        time: '5:00 PM',
        status: 'Completed',
      ),
      Booking(
        id: '11',
        name: 'Charity Event',
        venue: 'Crystal Room',
        date: '30 March, 2025',
        time: '5:00 PM',
        status: 'Completed',
      ),
    ]);
  }

  /// Filters bookings by status and sorts them based on the current sort option.
  List<Booking> getBookingsByStatus(String status) {
    var filtered = bookings.where((booking) => booking.status == status).toList();
    if (sortBy.value == 'By Venue') {
      filtered.sort((a, b) => a.venue.compareTo(b.venue));
    } else if (sortBy.value == 'By Date') {
      filtered.sort((a, b) {
        final dateA = _parseDate(a.date);
        final dateB = _parseDate(b.date);
        return dateA.compareTo(dateB);
      });
    }
    return filtered;
  }

  /// Parses a date string in "DD Month, YYYY" format to a DateTime object.
  DateTime _parseDate(String dateStr) {
    final parts = dateStr.split(' ');
    final day = int.parse(parts[0]);
    final monthStr = parts[1].replaceAll(',', '');
    final year = int.parse(parts[2]);
    const monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };
    final month = monthMap[monthStr] ?? 1;
    return DateTime(year, month, day);
  }

  /// Updates the sorting option and refreshes the bookings list.
  void setSortBy(String value) {
    sortBy.value = value;
    bookings.refresh();
  }

  /// Navigates to the details page for a booking (placeholder).
  void goToDetails(Booking booking) {
    Get.snackbar('Navigation', 'Navigating to details for ${booking.name}');
  }
}