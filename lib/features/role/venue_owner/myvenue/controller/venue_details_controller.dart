import 'dart:convert';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/model/venue_details_model.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:get/get.dart';

class VenueDetailsController extends GetxController {
  Rxn<VenueData> response = Rxn<VenueData>();
  final _logger = createLogger();

  @override
  void onInit() {
    super.onInit();
    getVenueDetails();
  }

  Future<void> getVenueDetails() async {
    try {
      _logger.i('Fetching venue details...');
      var apiResponse = await OwnerNetworkCaller().getRequest(
        showLoading: true,
        Url: Urls.getVenue('c426802e-34dc-45b6-b873-30d454311b36'),
      );

      _logger.i('API Response Status: ${apiResponse.isSuccess}');
      _logger.i('API Response Body: ${apiResponse.body}');

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

        if (jsonResponse['data'] != null) {
          response.value = VenueData.fromJson(jsonResponse['data']);
          _logger.i('VenueData set: ${response.value?.name}');
        } else {
          _logger.e('Data field is null in the response');
          throw Exception('Data field is null in the response');
        }
      } else {
        _logger.e('Failed to load venue details: ${apiResponse.body}');
        throw Exception('Failed to load venue details');
      }
    } catch (e) {
      _logger.e('Error fetching venue details: $e', );
      response.value = null; // Ensure response is null on error
      Get.snackbar('Error', 'Failed to load venue details: $e');
    }
  }
}