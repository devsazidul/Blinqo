import 'dart:convert';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/venue_details_model.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:get/get.dart';

class VenueDetailsController extends GetxController {
  Rxn<VenueDetails> response = Rxn<VenueDetails>();
  final _logger = createLogger();

  String id = '';

  @override
  void onInit() {
    super.onInit();
    getVenueDetails(id);
  }

  // Future<void> getVenueDetails(String id) async {
  //   try {
  //     _logger.i('Fetching venue details for ID: $id');
  //     var apiResponse = await OwnerNetworkCaller().getRequest(
  //       showLoading: true,
  //       Url: Urls.getVenue(id),
  //     );
  //
  //     _logger.i('API Response Status: ${apiResponse.isSuccess}');
  //     _logger.i('API Response Body: ${apiResponse.body}');
  //
  //     if (apiResponse.isSuccess) {
  //       Map<String, dynamic> jsonResponse;
  //       if (apiResponse.body is String) {
  //         jsonResponse = json.decode(apiResponse.body);
  //       } else if (apiResponse.body is Map<String, dynamic>) {
  //         jsonResponse = apiResponse.body;
  //       } else {
  //         _logger.e('Unexpected response body type: ${apiResponse.body.runtimeType}');
  //         throw Exception('Unexpected response body type');
  //       }
  //
  //       response.value = VenueDetails.fromJson(jsonResponse);
  //       _logger.i('VenueDetails set: ${response.value?.data?.venue?.name}');
  //     } else {
  //       _logger.e('Failed to load venue details: ${apiResponse.body}');
  //       throw Exception('Failed to load venue details');
  //     }
  //   } catch (e) {
  //     _logger.e('Error fetching venue details: $e');
  //     response.value = null;
  //     Get.snackbar('Error', 'Failed to load venue details: $e');
  //   }
  // }
  Future<void> getVenueDetails(String id) async {
    try {
      _logger.i('Fetching venue details for ID: $id');
      const mockJson = '''
{
  "data": {
    "venue": {
      "id": "a0f4b0b0-09eb-44ff-89b1-657fbdc33cdd",
      "profileId": "b1e21af3-bbbe-4507-a588-af88d4cab7cd",
      "name": "New Hall",
      "city": "Dhaka",
      "area": "Gulshan",
      "description": "A modern conference hall suitable for corporate events, weddings, and social gatherings.",
      "capacity": 150.0,
      "bookedDates": [],
      "type": "CONFERENCE_HALL",
      "cateringDescription": "In-house catering with customizable menus, including vegan and gluten-free options.",
      "parkingDescription": "Free parking for up to 50 vehicles, valet service available.",
      "availabilityDescription": "Available for bookings from 8 AM to 12 AM, subject to prior reservations.",
      "extraServiceDescription": "Projector, sound system, and live streaming services available on request.",
      "price": 6000.0,
      "bookingType": "INSTANT_BOOKING",
      "verified": true,
      "createdAt": "2025-05-12T06:18:21.381Z",
      "updatedAt": "2025-05-13T10:30:00Z",
      "amenities": [
        {
          "id": "3975c152-824b-47cd-89fd-e3f0829bba69",
          "name": "Wifi",
          "default": true,
          "profileId": null
        },
        {
          "id": "981771e7-615b-4031-ac09-a1b4600923b2",
          "name": "Parking",
          "default": true,
          "profileId": null
        },
        {
          "id": "4326e567-ea3e-45ea-b968-779fc3780443",
          "name": "AC",
          "default": true,
          "profileId": null
        },
        {
          "id": "6e5718b2-d828-4877-99c5-42aa5be79dc6",
          "name": "Pool",
          "default": false,
          "profileId": null
        },
        {
          "id": "f691a0e8-9522-4793-a234-2e64fd0b6aa8",
          "name": "Stage Lighting",
          "default": false,
          "profileId": null
        },
        {
          "id": "a1b2c3d4-e5f6-4789-aabc-1234567890ab",
          "name": "Sound System",
          "default": true,
          "profileId": null
        }
      ],
      "decoration": {
        "tableShapes": ["Round", "Rectangular", "Square"],
        "seatingStyles": ["Banquet", "Theatre", "Classroom"],
        "lighting": ["Ambient", "Spotlight", "Chandelier"],
        "flowerColors": ["White", "Red", "Yellow"],
        "flowerTypes": ["Roses", "Lilies", "Orchids"],
        "fragrances": ["Lavender", "Jasmine", "Rose"]
      },
      "arrangementsImage": {
        "path": "https://example.com/arrangements.jpg",
        "filename": "arrangements.jpg",
        "originalname": "arrangements.jpg",
        "size": 102400,
        "type": "image/jpeg"
      },
      "venueImage": {
        "path": "https://example.com/venue.jpg",
        "filename": "venue.jpg",
        "originalname": "venue.jpg",
        "size": 204800,
        "type": "image/jpeg"
      },
      "reviews": [
        {
          "id": "rev1",
          "comment": "Great venue, excellent service! The staff was very accommodating.",
          "rating": 4.5,
          "createdAt": "2025-05-10T10:00:00Z",
          "profile": {
            "id": "user1",
            "name": "John Doe",
            "image": {
              "path": "https://example.com/user1.jpg",
              "filename": "user1.jpg",
              "originalname": "user1.jpg",
              "size": 51200,
              "type": "image/jpeg"
            }
          }
        },
        {
          "id": "rev2",
          "comment": "Perfect for our corporate event. The AV equipment was top-notch!",
          "rating": 4.0,
          "createdAt": "2025-05-08T14:30:00Z",
          "profile": {
            "id": "user2",
            "name": "Sarah Islam",
            "image": {
              "path": "https://example.com/user2.jpg",
              "filename": "user2.jpg",
              "originalname": "user2.jpg",
              "size": 51200,
              "type": "image/jpeg"
            }
          }
        },
        {
          "id": "rev3",
          "comment": "Beautiful venue, but parking was a bit limited during peak hours.",
          "rating": 3.5,
          "createdAt": "2025-05-05T09:15:00Z",
          "profile": {
            "id": "user3",
            "name": "Ahmed Khan",
            "image": {
              "path": "",
              "filename": "user3.jpg",
              "originalname": "user3.jpg",
              "size": 51200,
              "type": "image/jpeg"
            }
          }
        },
        {
          "id": "rev4",
          "comment": "Hosted a wedding here, and it was unforgettable! Highly recommend.",
          "rating": 5.0,
          "createdAt": "2025-04-28T18:45:00Z",
          "profile": {
            "id": "user4",
            "name": "Fatima Rahman",
            "image": {
              "path": "https://example.com/user4.jpg",
              "filename": "user4.jpg",
              "originalname": "user4.jpg",
              "size": 51200,
              "type": "image/jpeg"
            }
          }
        }
      ]
    },
    "venueMetrics": {
      "totalRevenue": 25000.0,
      "currentMonthRevenue": 8000.0,
      "growthRate": 12.5,
      "pendingBookings": 3.0
    },
    "bookedDate": [
      {
        "id": "book1",
        "selectedDate": "2025-05-15T00:00:00Z",
        "startTime": "2025-05-15T09:00:00Z",
        "endTime": "2025-05-15T17:00:00Z",
        "duration": 8.0
      },
      {
        "id": "book2",
        "selectedDate": "2025-05-20T00:00:00Z",
        "startTime": "2025-05-20T10:00:00Z",
        "endTime": "2025-05-20T18:00:00Z",
        "duration": 8.0
      },
      {
        "id": "book3",
        "selectedDate": "2025-05-22T00:00:00Z",
        "startTime": "2025-05-22T14:00:00Z",
        "endTime": "2025-05-22T20:00:00Z",
        "duration": 6.0
      },
      {
        "id": "book4",
        "selectedDate": "2025-05-28T00:00:00Z",
        "startTime": "2025-05-28T11:00:00Z",
        "endTime": "2025-05-28T16:00:00Z",
        "duration": 5.0
      }
    ],
    "bookingRequest": [
      {
        "id": "req1",
        "bookedById": "user1",
        "venueId": "a0f4b0b0-09eb-44ff-89b1-657fbdc33cdd",
        "serviceProviderId": null,
        "eventName": "Corporate Meeting",
        "location": "Dhaka",
        "plannerName": "Jane Smith",
        "selectedDate": "2025-05-25T00:00:00Z",
        "startTime": "2025-05-25T09:00:00Z",
        "endTime": "2025-05-25T12:00:00Z",
        "duration": 3.0,
        "bookingType": "INSTANT_BOOKING",
        "guestNumber": 50.0,
        "decoration": "Minimalist",
        "services": ["Catering", "AV Equipment"],
        "bookingStatus": "Pending",
        "totalAmount": 3000.0,
        "paid": 1000.0,
        "due": 2000.0,
        "accept": null,
        "isEventFinished": false,
        "createdAt": "2025-05-11T08:00:00Z",
        "updatedAt": "2025-05-11T08:00:00Z",
        "eventTypeId": "event1",
        "eventType": {
          "id": "event1",
          "name": "Corporate",
          "avatar": {
            "path": "https://example.com/corporate.jpg",
            "filename": "corporate.jpg",
            "originalname": "corporate.jpg",
            "size": 51200,
            "type": "image/jpeg"
          }
        }
      },
      {
        "id": "req2",
        "bookedById": "user2",
        "venueId": "a0f4b0b0-09eb-44ff-89b1-657fbdc33cdd",
        "serviceProviderId": null,
        "eventName": "Wedding Reception",
        "location": "Dhaka",
        "plannerName": "Alice Johnson",
        "selectedDate": "2025-05-30T00:00:00Z",
        "startTime": "2025-05-30T18:00:00Z",
        "endTime": "2025-05-30T23:00:00Z",
        "duration": 5.0,
        "bookingType": "INSTANT_BOOKING",
        "guestNumber": 80.0,
        "decoration": "Floral",
        "services": ["Catering", "Photography"],
        "bookingStatus": "Accepted",
        "totalAmount": 8000.0,
        "paid": 8000.0,
        "due": 0.0,
        "accept": "true",
        "isEventFinished": false,
        "createdAt": "2025-05-10T09:00:00Z",
        "updatedAt": "2025-05-11T10:00:00Z",
        "eventTypeId": "event2",
        "eventType": {
          "id": "event2",
          "name": "Wedding",
          "avatar": {
            "path": "https://example.com/wedding.jpg",
            "filename": "wedding.jpg",
            "originalname": "wedding.jpg",
            "size": 51200,
            "type": "image/jpeg"
          }
        }
      },
      {
        "id": "req3",
        "bookedById": "user3",
        "venueId": "a0f4b0b0-09eb-44ff-89b1-657fbdc33cdd",
        "serviceProviderId": null,
        "eventName": "Birthday Party",
        "location": "Dhaka",
        "plannerName": "Mohammad Ali",
        "selectedDate": "2025-06-01T00:00:00Z",
        "startTime": "2025-06-01T16:00:00Z",
        "endTime": "2025-06-01T21:00:00Z",
        "duration": 5.0,
        "bookingType": "INSTANT_BOOKING",
        "guestNumber": 30.0,
        "decoration": "Colorful Balloons",
        "services": ["Catering", "DJ"],
        "bookingStatus": "Pending",
        "totalAmount": 2000.0,
        "paid": 500.0,
        "due": 1500.0,
        "accept": null,
        "isEventFinished": false,
        "createdAt": "2025-05-12T15:00:00Z",
        "updatedAt": "2025-05-12T15:00:00Z",
        "eventTypeId": "event3",
        "eventType": {
          "id": "event3",
          "name": "Birthday",
          "avatar": {
            "path": "https://example.com/birthday.jpg",
            "filename": "birthday.jpg",
            "originalname": "birthday.jpg",
            "size": 51200,
            "type": "image/jpeg"
          }
        }
      },
      {
        "id": "req4",
        "bookedById": "user4",
        "venueId": "a0f4b0b0-09eb-44ff-89b1-657fbdc33cdd",
        "serviceProviderId": null,
        "eventName": "Seminar",
        "location": "Dhaka",
        "plannerName": "Sadia Chowdhury",
        "selectedDate": "2025-06-05T00:00:00Z",
        "startTime": "2025-06-05T10:00:00Z",
        "endTime": "2025-06-05T14:00:00Z",
        "duration": 4.0,
        "bookingType": "INSTANT_BOOKING",
        "guestNumber": 60.0,
        "decoration": "Professional",
        "services": ["AV Equipment", "Catering"],
        "bookingStatus": "Rejected",
        "totalAmount": 4000.0,
        "paid": 0.0,
        "due": 4000.0,
        "accept": "false",
        "isEventFinished": false,
        "createdAt": "2025-05-09T12:00:00Z",
        "updatedAt": "2025-05-10T14:00:00Z",
        "eventTypeId": "event1",
        "eventType": {
          "id": "event1",
          "name": "Corporate",
          "avatar": {
            "path": "https://example.com/corporate.jpg",
            "filename": "corporate.jpg",
            "originalname": "corporate.jpg",
            "size": 51200,
            "type": "image/jpeg"
          }
        }
      }
    ],
    "ratting": 4
  },
  "message": "Venue details retrieved successfully",
  "statusCode": 200,
  "success": true
}
''';
      Map<String, dynamic> jsonResponse = json.decode(mockJson);
      response.value = VenueDetails.fromJson(jsonResponse);
      _logger.i('VenueDetails set: ${response.value?.data?.venue?.name}');
    } catch (e, stackTrace) {
      _logger.e('Error fetching venue details: $e', stackTrace: stackTrace);
      response.value = null;
      Get.snackbar('Error', 'Failed to load venue details: $e');
    }
  }
}
