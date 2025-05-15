import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/overview/model/venue_overview_model.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class OverviewController extends GetxController {
  final _logger = Logger();
  final Rx<VenueOverView?> venueOverView = Rx<VenueOverView?>(null);
  final RxBool isLoading = false.obs;

  // Demo data embedded in the controller
  final Map<String, dynamic> _demoData = {
    "data": {
      "analytics": {
        "totalRevenue": 75000.0,
        "currentMonthRevenue": 12000.0,
        "previousMonthRevenue": 10000.0,
        "growthRate": 20.0,
        "totalPendingBookings": 4,
        "totalVenues": 3
      },
      "upcomingEvents": [
        {
          "id": "event_001",
          "bookedById": "user_101",
          "venueId": "venue_001",
          "serviceProviderId": null,
          "eventName": "Annual Corporate Gala",
          "location": "Dhaka, Bangladesh",
          "plannerName": "Sarah Johnson",
          "selectedDate": "2025-06-10T00:00:00Z",
          "startTime": "2025-06-10T18:00:00Z",
          "endTime": "2025-06-10T23:00:00Z",
          "duration": 5,
          "bookingType": "INSTANT_BOOKING",
          "guestNumber": 200,
          "decoration": "{\"tableShapes\": [\"Round\"], \"seatingStyles\": [\"Banquet\"]}",
          "services": ["Catering", "AV Equipment", "Decor"],
          "bookingStatus": "Confirmed",
          "totalAmount": 5000,
          "paid": 2000,
          "due": 3000,
          "accept": "true",
          "isEventFinished": false,
          "createdAt": "2025-05-12T10:00:00Z",
          "updatedAt": "2025-05-13T15:30:00Z",
          "eventTypeId": "corporate_event",
          "venue": {
            "name": "Grand Ballroom",
            "area": "Gulshan",
            "venueImage": {
              "path": "https://example.com/images/venue_grand_ballroom.jpg"
            }
          }
        },
        {
          "id": "event_002",
          "bookedById": "user_102",
          "venueId": "venue_002",
          "serviceProviderId": "provider_001",
          "eventName": "Wedding Reception",
          "location": "Chittagong, Bangladesh",
          "plannerName": "Ayesha Rahman",
          "selectedDate": "2025-06-15T00:00:00Z",
          "startTime": "2025-06-15T17:00:00Z",
          "endTime": "2025-06-15T22:00:00Z",
          "duration": 5,
          "bookingType": "REQUEST_BOOKING",
          "guestNumber": 150,
          "decoration": "{\"tableShapes\": [\"Oval\"], \"seatingStyles\": [\"Theater\"]}",
          "services": ["Catering", "Photography"],
          "bookingStatus": "Pending",
          "totalAmount": 4000,
          "paid": 1000,
          "due": 3000,
          "accept": "pending",
          "isEventFinished": false,
          "createdAt": "2025-05-14T08:00:00Z",
          "updatedAt": "2025-05-14T09:00:00Z",
          "eventTypeId": "wedding_event",
          "venue": {
            "name": "Ocean View Resort",
            "area": "Cox’s Bazar",
            "venueImage": {
              "path": "https://example.com/images/venue_ocean_view.jpg"
            }
          }
        },
        {
          "id": "event_003",
          "bookedById": "user_103",
          "venueId": "venue_003",
          "serviceProviderId": null,
          "eventName": "Tech Conference",
          "location": "Dhaka, Bangladesh",
          "plannerName": "Michael Lee",
          "selectedDate": "2025-06-20T00:00:00Z",
          "startTime": "2025-06-20T09:00:00Z",
          "endTime": "2025-06-20T17:00:00Z",
          "duration": 8,
          "bookingType": "INSTANT_BOOKING",
          "guestNumber": 300,
          "decoration": "{\"tableShapes\": [\"Rectangular\"], \"seatingStyles\": [\"Classroom\"]}",
          "services": ["AV Equipment", "WiFi"],
          "bookingStatus": "Confirmed",
          "totalAmount": 6000,
          "paid": 3000,
          "due": 3000,
          "accept": "true",
          "isEventFinished": false,
          "createdAt": "2025-05-10T12:00:00Z",
          "updatedAt": "2025-05-11T14:00:00Z",
          "eventTypeId": "conference_event",
          "venue": {
            "name": "Tech Hub Convention Center",
            "area": "Banani",
            "venueImage": {
              "path": "https://example.com/images/venue_tech_hub.jpg"
            }
          }
        }
      ],
      "recentReviews": [
        {
          "id": "review_001",
          "venueId": "venue_001",
          "rating": 4.5,
          "comment": "The Grand Ballroom was perfect for our gala. The staff was professional, and the ambiance was stunning. Only minor issue was parking availability.",
          "createdAt": "2025-05-08T14:30:00Z",
          "profileId": "user_201",
          "profile": {
            "name": "Emily Davis",
            "image": {
              "path": "https://example.com/images/user_emily.jpg"
            }
          }
        },
        {
          "id": "review_002",
          "venueId": "venue_002",
          "rating": 4.0,
          "comment": "Ocean View Resort was beautiful, but the event setup took longer than expected. Overall, a great experience with excellent food.",
          "createdAt": "2025-05-10T09:15:00Z",
          "profileId": "user_202",
          "profile": {
            "name": "Rahul Khan",
            "image": {
              "path": "https://example.com/images/user_rahul.jpg"
            }
          }
        },
        {
          "id": "review_003",
          "venueId": "venue_003",
          "rating": 5.0,
          "comment": "Tech Hub Convention Center exceeded expectations! The AV equipment was top-notch, and the venue was spacious and well-organized.",
          "createdAt": "2025-05-12T16:45:00Z",
          "profileId": "user_203",
          "profile": {
            "name": "Sophie Chen",
            "image": {
              "path": "https://example.com/images/user_sophie.jpg"
            }
          }
        }
      ]
    },
    "message": "Venue overview retrieved successfully",
    "statusCode": 200,
    "success": true
  };

  @override
  void onInit() {
    super.onInit();
    fetchVenueOverview();
  }

  Future<void> fetchVenueOverview() async {
    _logger.i('Fetching venue overview from ${Urls.getVenueOwnerHome}');
    isLoading.value = true;

    try {
      // Attempt real API call
      final response = await OwnerNetworkCaller().getRequest(
        Url: Urls.getVenueOwnerHome,
        showLoading: true,
      );

      if (response.isSuccess) {
        _logger.i('Venue overview fetched successfully: ${response.body}');
        venueOverView.value = VenueOverView.fromJson(_demoData);
        EasyLoading.showSuccess('Data loaded successfully');
      } else {
        _logger.w('API failed, using demo data: ${response.errorMessage}');
        // Fallback to demo data
        venueOverView.value = VenueOverView.fromJson(_demoData);
        EasyLoading.showInfo('Loaded demo data due to API failure');
      }
    } catch (e, stackTrace) {
      _logger.e('Error fetching venue overview, using demo data: $e', stackTrace: stackTrace);
      // Fallback to demo data on error
      venueOverView.value = VenueOverView.fromJson(_demoData);
      EasyLoading.showInfo('Loaded demo data due to error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}