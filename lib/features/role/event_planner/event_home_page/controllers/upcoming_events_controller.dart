import 'package:get/get.dart';

class UpcomingEventsController extends GetxController {
  // Reactive list of events
  var upcomingEvents = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingEvents(); // Fetch data when the controller initializes
  }

  // Simulate fetching data from an API
  void fetchUpcomingEvents() async {

    // Replace this with an actual API call
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    upcomingEvents.assignAll([
      {
        'title': 'The Community Block Party',
        'venue': 'Whispering Pines Lodge',
        'date': '15 March, 2025',
        'location': 'New York',
        'status': 'Confirmed',
      },
      {
        'title': 'Spring Festival',
        'venue': 'Central Park Venue',
        'date': '20 April, 2025',
        'location': 'Los Angeles',
        'status': 'Confirmed',
      },
      {
        'title': 'Summer Concert',
        'venue': 'Ocean View Hall',
        'date': '10 June, 2025',
        'location': 'San Francisco',
        'status': 'In Progress',
      },
    ]);
  }
}