import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:get/get.dart';

class UpcomingEventsController extends GetxController {
  // Reactive list of events
  var upcomingEvents = <Map<String, dynamic>>[].obs;
  var isContainerVisible = false.obs;
  var vnIsFavorite = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingEvents();
  }

  void fetchUpcomingEvents() async {
    await Future.delayed(Duration(seconds: 2));
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

  final List<Map<String, dynamic>> venues = [
    {
      "name": 'The Grand Hall',
      "location": 'New York',
      "rating": 4.5,
      "guestCapacity": 300,
      "imagePath": ImagePath.myvenue1,
    },
    {
      "name": 'Central Park Venue',
      "location": 'Los Angeles',
      "rating": 4.0,
      "guestCapacity": 200,
      "imagePath": ImagePath.myvenue2,
    },
    {
      "name": 'Ocean View Hall',
      "location": 'San Francisco',
      "rating": 4.3,
      "guestCapacity": 150,
      "imagePath": ImagePath.filter,
    },
    {
      "name": 'Central Park Venue',
      "location": 'Los Angeles',
      "rating": 4.0,
      "guestCapacity": 200,
      "imagePath": ImagePath.myvenue2,
    },
  ];

  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
  }

  void removeEvent(int index) {
    upcomingEvents.removeAt(index);
  }

  void removeVenue(int index) {
    venues.removeAt(index);
  }
}
