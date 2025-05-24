import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EpBookingController extends GetxController {
  // Observable list of bookings
  final bookings =
      <Map<String, dynamic>>[
        {
          'eventName': "John's Birthday Party",
          'venue': 'ABC Place, New York',
          'totalCost': 5000,
          'date': DateTime(2024, 3, 15),
          'dayName': 'Friday',
        },
        {
          'eventName': "Wedding Reception",
          'venue': 'Grand Hall, Boston',
          'totalCost': 8000,
          'date': DateTime(2024, 3, 20),
          'dayName': 'Wednesday',
        },
        {
          'eventName': "Annual Corporate Meeting",
          'venue': 'Business Center, Chicago',
          'totalCost': 12000,
          'date': DateTime(2024, 3, 10),
          'dayName': 'Sunday',
        },
        {
          'eventName': "Music Festival",
          'venue': 'Central Park, New York',
          'totalCost': 15000,
          'date': DateTime(2024, 4, 5),
          'dayName': 'Friday',
        },
        {
          'eventName': "Charity Gala",
          'venue': 'Luxury Hotel, Miami',
          'totalCost': 10000,
          'date': DateTime(2024, 3, 25),
          'dayName': 'Monday',
        },
        {
          'eventName': "Product Launch",
          'venue': 'Tech Hub, San Francisco',
          'totalCost': 20000,
          'date': DateTime(2024, 4, 1),
          'dayName': 'Monday',
        },
      ].obs;

  // Current sort type
  final sortType = 'name'.obs;

  // Sort bookings by name
  void sortByName() {
    bookings.sort((a, b) => a['eventName'].compareTo(b['eventName']));
    sortType.value = 'name';
  }

  // Sort bookings by date
  void sortByDate() {
    bookings.sort((a, b) => b['date'].compareTo(a['date']));
    sortType.value = 'date';
  }

  // Sort bookings by day name
  void sortByDay() {
    bookings.sort((a, b) => a['dayName'].compareTo(b['dayName']));
    sortType.value = 'day';
  }

  // Format date to string
  String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
