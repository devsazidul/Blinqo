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
          "description": "A modern conference hall suitable for corporate events and weddings.",
          "capacity": 100,
          "bookedDates": [],
          "type": "CONFERENCE_HALL",
          "cateringDescription": "In-house catering with customizable menus.",
          "parkingDescription": "Free parking for up to 50 vehicles.",
          "availabilityDescription": "Available for bookings from 9 AM to 11 PM.",
          "extraServiceDescription": "Projector and sound system available on request.",
          "price": 5000,
          "bookingType": "INSTANT_BOOKING",
          "verified": true,
          "createdAt": "2025-05-12T06:18:21.381Z",
          "updatedAt": "2025-05-12T06:18:21.381Z",
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
            }
          ],
          "decoration": {
            "tableShapes": ["Round", "Rectangular"],
            "seatingStyles": ["Banquet", "Theatre"],
            "lighting": ["Ambient", "Spotlight"],
            "flowerColors": ["White", "Red"],
            "flowerTypes": ["Roses", "Lilies"],
            "fragrances": ["Lavender", "Jasmine"]
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
              "comment": "Great venue, excellent service!",
              "rating": 4,
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
            }
          ]
        },
        "venueMetrics": {
          "totalRevenue": 15000,
          "currentMonthRevenue": 5000,
          "growthRate": 10,
          "pendingBookings": 2
        },
        "bookedDate": [
          {
            "id": "book1",
            "selectedDate": "2025-05-15T00:00:00Z",
            "startTime": "2025-05-15T09:00:00Z",
            "endTime": "2025-05-15T17:00:00Z",
            "duration": 8
          },
          {
            "id": "book2",
            "selectedDate": "2025-05-20T00:00:00Z",
            "startTime": "2025-05-20T10:00:00Z",
            "endTime": "2025-05-20T18:00:00Z",
            "duration": 8
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
            "duration": 3,
            "bookingType": "INSTANT_BOOKING",
            "guestNumber": 50,
            "decoration": "Minimalist",
            "services": ["Catering", "AV Equipment"],
            "bookingStatus": "Pending",
            "totalAmount": 3000,
            "paid": 1000,
            "due": 2000,
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
            "duration": 5,
            "bookingType": "INSTANT_BOOKING",
            "guestNumber": 80,
            "decoration": "Floral",
            "services": ["Catering", "Photography"],
            "bookingStatus": "Accepted",
            "totalAmount": 8000,
            "paid": 8000,
            "due": 0,
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