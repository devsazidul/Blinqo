import 'dart:convert';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/all_venue_details_model.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';

class AllVenuesDetailsController extends GetxController {
  final _logger = createLogger();
  RxList<Map<String, String>> filteredVenues = <Map<String, String>>[].obs;
  RxList<bool> favoriteList = <bool>[].obs;
  Rxn<AllVenueDetails> response = Rxn<AllVenueDetails>();

  @override
  void onInit() {
    super.onInit();
    getAllVenues();
  }

  Future<void> getAllVenues() async {
    try {

      var apiResponse = await OwnerNetworkCaller().getRequest(
        showLoading: true,
        Url: Urls.getAllVenue,
      );


      if (apiResponse.isSuccess) {
        Map<String, dynamic> jsonResponse;

        if (apiResponse.body is String) {
          jsonResponse = json.decode(apiResponse.body);
        } else if (apiResponse.body is Map<String, dynamic>) {
          jsonResponse = apiResponse.body;
        } else {
          _logger.e('Unexpected response body type: ${apiResponse.body.runtimeType}');
          throw Exception('Unexpected response body type');
        }

        response.value = AllVenueDetails.fromJson(jsonResponse);
        _logger.i('Fetched ${response.value?.data.length} venues');

        // Map VenueData to UI format
        filteredVenues.value = response.value?.data.map((venue) => {
          'title': venue.name ?? 'Unknown Venue',
          'address': '${venue.city ?? ''}, ${venue.area ?? ''}',
          'guest': '${venue.capacity ?? 0} Guests',
          'rating': venue.averageRating?.toString() ?? '0',
          'image': venue.venueImage?.path ?? ImagePath.venueview,
          'id': venue.id ?? '',
        }).toList() ?? [];

        // Initialize favorite list (all false initially)
        favoriteList.value = List<bool>.filled(filteredVenues.length, false);
      } else {
        _logger.e('Failed to load venues: ${apiResponse.body}');
        throw Exception('Failed to load venues');
      }
    } catch (e) {
      _logger.e('Error fetching venues: $e', );
      response.value = null;
      filteredVenues.clear();
      favoriteList.clear();
      EasyLoading.showError('Failed to load venues: $e');
    }
  }

  void filterVenues(String query) {
    if (query.isEmpty) {
      filteredVenues.value = response.value?.data.map((venue) => {
        'title': venue.name ?? 'Unknown Venue',
        'address': '${venue.city ?? ''}, ${venue.area ?? ''}',
        'guest': '${venue.capacity ?? 0} Guests',
        'rating': venue.averageRating?.toString() ?? '0',
        'image': venue.venueImage?.path ?? ImagePath.venueview,
      }).toList() ?? [];
    } else {
      filteredVenues.value = response.value?.data
          .where((venue) =>
      venue.name?.toLowerCase().contains(query.toLowerCase()) == true)
          .map((venue) => {
        'title': venue.name ?? 'Unknown Venue',
        'address': '${venue.city ?? ''}, ${venue.area ?? ''}',
        'guest': '${venue.capacity ?? 0} Guests',
        'rating': venue.averageRating?.toString() ?? '0',
        'image': venue.venueImage?.path ?? ImagePath.venueview,
      })
          .toList() ?? [];
    }
    // Update favorite list to match filtered venues
    favoriteList.value = List<bool>.filled(filteredVenues.length, false);
  }

  void toggleFavorite(int index) {
    favoriteList[index] = !favoriteList[index];
    favoriteList.refresh();
  }
}