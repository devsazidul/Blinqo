import 'package:blinqo/features/role/event_planner/home/model/ep_venues_response_model.dart'
    show FeaturedVenue;
import 'package:get/get.dart';

class EpVenueCompareController extends GetxController {
  var venues = <FeaturedVenue>[].obs;

  void addVenueToCompare(FeaturedVenue venue) {
    // check if venue is already in the list, check by venue id, if exists, don't do anythings
    if (venues.any((element) => element.id == venue.id)) {
      return;
    }
    venues.add(venue);
    update();
  }

  void removeVenueFromCompare(String venueId) {
    venues.removeWhere((element) => element.id == venueId);
    // update the list
    update();
  }
}
