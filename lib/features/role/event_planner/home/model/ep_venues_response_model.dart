class EpVenuesResponseModel {
  CountdownEvent? countdownEvent;
  List<FeaturedVenue>? featuredVenues;
  List<dynamic>? upcomingEvents;
  List<EventService>? eventServices;

  EpVenuesResponseModel({
    this.countdownEvent,
    this.featuredVenues,
    this.upcomingEvents,
    this.eventServices,
  });

  factory EpVenuesResponseModel.fromJson(Map<String, dynamic> json) {
    return EpVenuesResponseModel(
      countdownEvent:
          json['countdownEvent'] != null
              ? CountdownEvent.fromJson(json['countdownEvent'])
              : null,
      featuredVenues:
          json['featuredVenues'] != null
              ? (json['featuredVenues'] as List)
                  .map((venue) => FeaturedVenue.fromJson(venue))
                  .toList()
              : null,
      upcomingEvents: json['upcomingEvents'] as List?,
      eventServices:
          json['eventServices'] != null
              ? (json['eventServices'] as List)
                  .map((service) => EventService.fromJson(service))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countdownEvent': countdownEvent?.toJson(),
      'featuredVenues': featuredVenues?.map((venue) => venue.toJson()).toList(),
      'upcomingEvents': upcomingEvents,
      'eventServices':
          eventServices?.map((service) => service.toJson()).toList(),
    };
  }
}

class CountdownEvent {
  // Add properties when countdownEvent structure is known
  CountdownEvent();

  factory CountdownEvent.fromJson(Map<String, dynamic> json) {
    return CountdownEvent();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class FeaturedVenue {
  String? id;
  String? profileId;
  String? name;
  String? city;
  String? area;
  String? description;
  int? capacity;
  List<dynamic>? bookedDates;
  String? type;
  String? cateringDescription;
  String? parkingDescription;
  String? availabilityDescription;
  String? extraServiceDescription;
  int? price;
  String? bookingType;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  String? status;
  VenueImage? venueImage;

  FeaturedVenue({
    this.id,
    this.profileId,
    this.name,
    this.city,
    this.area,
    this.description,
    this.capacity,
    this.bookedDates,
    this.type,
    this.cateringDescription,
    this.parkingDescription,
    this.availabilityDescription,
    this.extraServiceDescription,
    this.price,
    this.bookingType,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.venueImage,
  });

  factory FeaturedVenue.fromJson(Map<String, dynamic> json) {
    return FeaturedVenue(
      id: json['id'] as String?,
      profileId: json['profileId'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String?,
      area: json['area'] as String?,
      description: json['description'] as String?,
      capacity: json['capacity'] as int?,
      bookedDates: json['bookedDates'] as List?,
      type: json['type'] as String?,
      cateringDescription: json['cateringDescription'] as String?,
      parkingDescription: json['parkingDescription'] as String?,
      availabilityDescription: json['availabilityDescription'] as String?,
      extraServiceDescription: json['extraServiceDescription'] as String?,
      price: json['price'] as int?,
      bookingType: json['bookingType'] as String?,
      verified: json['verified'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as String?,
      venueImage:
          json['venueImage'] != null
              ? VenueImage.fromJson(json['venueImage'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'name': name,
      'city': city,
      'area': area,
      'description': description,
      'capacity': capacity,
      'bookedDates': bookedDates,
      'type': type,
      'cateringDescription': cateringDescription,
      'parkingDescription': parkingDescription,
      'availabilityDescription': availabilityDescription,
      'extraServiceDescription': extraServiceDescription,
      'price': price,
      'bookingType': bookingType,
      'verified': verified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
      'venueImage': venueImage?.toJson(),
    };
  }
}

class VenueImage {
  String? id;
  String? name;
  String? fileId;
  String? path;
  String? createdAt;
  String? expiresAt;
  String? bucket;
  String? type;
  String? venueId;
  String? venueDecorationId;
  String? eventPreferenceId;
  String? profileId;
  String? directMessageId;
  String? nationalIdCardId;
  String? tradeLicenseCardId;
  String? groupMessageId;
  String? worksId;
  String? serviceProviderTypeId;

  VenueImage({
    this.id,
    this.name,
    this.fileId,
    this.path,
    this.createdAt,
    this.expiresAt,
    this.bucket,
    this.type,
    this.venueId,
    this.venueDecorationId,
    this.eventPreferenceId,
    this.profileId,
    this.directMessageId,
    this.nationalIdCardId,
    this.tradeLicenseCardId,
    this.groupMessageId,
    this.worksId,
    this.serviceProviderTypeId,
  });

  factory VenueImage.fromJson(Map<String, dynamic> json) {
    return VenueImage(
      id: json['id'] as String?,
      name: json['name'] as String?,
      fileId: json['fileId'] as String?,
      path: json['path'] as String?,
      createdAt: json['createdAt'] as String?,
      expiresAt: json['expiresAt'] as String?,
      bucket: json['bucket'] as String?,
      type: json['type'] as String?,
      venueId: json['venueId'] as String?,
      venueDecorationId: json['venueDecorationId'] as String?,
      eventPreferenceId: json['eventPreferenceId'] as String?,
      profileId: json['profileId'] as String?,
      directMessageId: json['directMessageId'] as String?,
      nationalIdCardId: json['nationalIdCardId'] as String?,
      tradeLicenseCardId: json['tradeLicenseCardId'] as String?,
      groupMessageId: json['groupMessageId'] as String?,
      worksId: json['worksId'] as String?,
      serviceProviderTypeId: json['serviceProviderTypeId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fileId': fileId,
      'path': path,
      'createdAt': createdAt,
      'expiresAt': expiresAt,
      'bucket': bucket,
      'type': type,
      'venueId': venueId,
      'venueDecorationId': venueDecorationId,
      'eventPreferenceId': eventPreferenceId,
      'profileId': profileId,
      'directMessageId': directMessageId,
      'nationalIdCardId': nationalIdCardId,
      'tradeLicenseCardId': tradeLicenseCardId,
      'groupMessageId': groupMessageId,
      'worksId': worksId,
      'serviceProviderTypeId': serviceProviderTypeId,
    };
  }
}

class EventService {
  String? id;
  String? name;

  EventService({this.id, this.name});

  factory EventService.fromJson(Map<String, dynamic> json) {
    return EventService(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

/*
{
  "countdownEvent": null,
  "featuredVenues": [
    {
      "id": "1a62a642-5826-4dc3-a16c-85363789b6ed",
      "profileId": "b18d2310-1d9f-4f48-b197-feffdee04d30",
      "name": "Mukarrom vai",
      "city": "dfsdf",
      "area": "fdsfsd",
      "description": null,
      "capacity": 1000,
      "bookedDates": [],
      "type": "RESTAURANT",
      "cateringDescription": null,
      "parkingDescription": null,
      "availabilityDescription": null,
      "extraServiceDescription": null,
      "price": 0,
      "bookingType": "INSTANT_BOOKING",
      "verified": true,
      "createdAt": "2025-05-13T08:28:06.333Z",
      "updatedAt": "2025-05-15T04:47:32.632Z",
      "status": "ACTIVE",
      "venueImage": {
        "id": "013b2673-2a63-499e-b2f8-f4914f1f08db",
        "name": "18.jpg",
        "fileId": "18.jpg-783eb60e-8ba6-43a1-b5b5-b0a87d817094",
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/18.jpg-783eb60e-8ba6-43a1-b5b5-b0a87d817094?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T085825Z&X-Amz-Expires=604800&X-Amz-Signature=6aaf85e7e9f5266ea8685d35728bff8691f8d48b985499d819fd399666b7c220&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        "createdAt": "2025-05-14T08:58:25.792Z",
        "expiresAt": "2025-05-21T08:58:25.791Z",
        "bucket": "test",
        "type": "DOCUMENT",
        "venueId": "1a62a642-5826-4dc3-a16c-85363789b6ed",
        "venueDecorationId": null,
        "eventPreferenceId": null,
        "profileId": null,
        "directMessageId": null,
        "nationalIdCardId": null,
        "tradeLicenseCardId": null,
        "groupMessageId": null,
        "worksId": null,
        "serviceProviderTypeId": null
      }
    },
    {
      "id": "5533523c-357d-41b0-911d-ea9482739ecd",
      "profileId": "b18d2310-1d9f-4f48-b197-feffdee04d30",
      "name": "Ambon Complex Hall new",
      "city": "Mohakhali",
      "area": "Dhaka",
      "description": null,
      "capacity": 250,
      "bookedDates": [],
      "type": "BANQUET",
      "cateringDescription": null,
      "parkingDescription": null,
      "availabilityDescription": null,
      "extraServiceDescription": null,
      "price": 0,
      "bookingType": "INSTANT_BOOKING",
      "verified": true,
      "createdAt": "2025-05-14T04:09:56.205Z",
      "updatedAt": "2025-05-15T04:47:32.632Z",
      "status": "ACTIVE",
      "venueImage": {
        "id": "3f66cc38-bd69-4896-9cbb-3335d26763d2",
        "name": "20.jpg",
        "fileId": "20.jpg-1b857d51-23fd-465e-891f-1cb878cd78e5",
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/20.jpg-1b857d51-23fd-465e-891f-1cb878cd78e5?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T040956Z&X-Amz-Expires=604800&X-Amz-Signature=455b9f9bcf4bd35155fa560a6770050e803fcdef07eb0e47ccc85ebba87b62d9&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        "createdAt": "2025-05-14T04:09:56.200Z",
        "expiresAt": "2025-05-21T04:09:56.198Z",
        "bucket": "test",
        "type": "DOCUMENT",
        "venueId": "5533523c-357d-41b0-911d-ea9482739ecd",
        "venueDecorationId": null,
        "eventPreferenceId": null,
        "profileId": null,
        "directMessageId": null,
        "nationalIdCardId": null,
        "tradeLicenseCardId": null,
        "groupMessageId": null,
        "worksId": null,
        "serviceProviderTypeId": null
      }
    },
    {
      "id": "60b21e93-1102-4e44-95a6-80290243c33f",
      "profileId": "b18d2310-1d9f-4f48-b197-feffdee04d30",
      "name": "test2",
      "city": "fdsf",
      "area": "dfsadfdsa",
      "description": null,
      "capacity": 5252,
      "bookedDates": [],
      "type": "BANQUET",
      "cateringDescription": null,
      "parkingDescription": null,
      "availabilityDescription": null,
      "extraServiceDescription": null,
      "price": 0,
      "bookingType": "INSTANT_BOOKING",
      "verified": true,
      "createdAt": "2025-05-13T10:08:43.343Z",
      "updatedAt": "2025-05-15T04:47:32.632Z",
      "status": "ACTIVE",
      "venueImage": {
        "id": "6ec8f38a-dc79-4e4a-8d7f-3a48c387ba3f",
        "name": "46f9b70d-0a67-4465-9127-a2da260bad6e642417891333310885.jpg",
        "fileId": "46f9b70d-0a67-4465-9127-a2da260bad6e642417891333310885.jpg-d11fe17a-d337-432f-81df-7ab8505db9ba",
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/46f9b70d-0a67-4465-9127-a2da260bad6e642417891333310885.jpg-d11fe17a-d337-432f-81df-7ab8505db9ba?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250513%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250513T100843Z&X-Amz-Expires=604800&X-Amz-Signature=c27416a5f3299406c58ff2d1472fc6a566dccd5c2cf142336c4ecf085751bb78&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        "createdAt": "2025-05-13T10:08:43.337Z",
        "expiresAt": "2025-05-20T10:08:43.336Z",
        "bucket": "test",
        "type": "DOCUMENT",
        "venueId": "60b21e93-1102-4e44-95a6-80290243c33f",
        "venueDecorationId": null,
        "eventPreferenceId": null,
        "profileId": null,
        "directMessageId": null,
        "nationalIdCardId": null,
        "tradeLicenseCardId": null,
        "groupMessageId": null,
        "worksId": null,
        "serviceProviderTypeId": null
      }
    },
    {
      "id": "f3d84667-e229-4fca-b99e-ed92d8174f7c",
      "profileId": "b18d2310-1d9f-4f48-b197-feffdee04d30",
      "name": "test 1",
      "city": "Dhaka",
      "area": "Bangladesh",
      "description": null,
      "capacity": 1030,
      "bookedDates": [],
      "type": "RESORT",
      "cateringDescription": null,
      "parkingDescription": null,
      "availabilityDescription": null,
      "extraServiceDescription": null,
      "price": 0,
      "bookingType": "INSTANT_BOOKING",
      "verified": true,
      "createdAt": "2025-05-13T10:05:07.411Z",
      "updatedAt": "2025-05-15T04:47:32.632Z",
      "status": "ACTIVE",
      "venueImage": {
        "id": "1a9220ef-dc82-4900-a443-c1ff87105f09",
        "name": "5241b08b-d85b-436f-a101-caa8a51582116865174261047299663.jpg",
        "fileId": "5241b08b-d85b-436f-a101-caa8a51582116865174261047299663.jpg-ba5cb673-1075-485e-af4a-11273b21be08",
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/5241b08b-d85b-436f-a101-caa8a51582116865174261047299663.jpg-ba5cb673-1075-485e-af4a-11273b21be08?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250513%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250513T100507Z&X-Amz-Expires=604800&X-Amz-Signature=bebb0341d88642c864a5703fac84689e01b580d1e8d90150f5756032f87259ec&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        "createdAt": "2025-05-13T10:05:07.402Z",
        "expiresAt": "2025-05-20T10:05:07.401Z",
        "bucket": "test",
        "type": "DOCUMENT",
        "venueId": "f3d84667-e229-4fca-b99e-ed92d8174f7c",
        "venueDecorationId": null,
        "eventPreferenceId": null,
        "profileId": null,
        "directMessageId": null,
        "nationalIdCardId": null,
        "tradeLicenseCardId": null,
        "groupMessageId": null,
        "worksId": null,
        "serviceProviderTypeId": null
      }
    },
    {
      "id": "ff81d498-b7a0-493c-8a49-f008d7625fbc",
      "profileId": "b18d2310-1d9f-4f48-b197-feffdee04d30",
      "name": "fdsfd",
      "city": "dfsdf",
      "area": "fdsfsd",
      "description": null,
      "capacity": 1000,
      "bookedDates": [],
      "type": "RESTAURANT",
      "cateringDescription": null,
      "parkingDescription": null,
      "availabilityDescription": null,
      "extraServiceDescription": null,
      "price": 0,
      "bookingType": "INSTANT_BOOKING",
      "verified": true,
      "createdAt": "2025-05-13T09:59:48.672Z",
      "updatedAt": "2025-05-15T04:47:32.632Z",
      "status": "ACTIVE",
      "venueImage": {
        "id": "b5f730ca-ddd6-4733-af1b-261384cc076f",
        "name": "7a507c57-b4a7-46cd-9670-e0e396d0e9db8792820604435414026.jpg",
        "fileId": "7a507c57-b4a7-46cd-9670-e0e396d0e9db8792820604435414026.jpg-8c78e1c2-a0d9-4c59-8b2d-4d3f82db97e7",
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/7a507c57-b4a7-46cd-9670-e0e396d0e9db8792820604435414026.jpg-8c78e1c2-a0d9-4c59-8b2d-4d3f82db97e7?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250513%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250513T095948Z&X-Amz-Expires=604800&X-Amz-Signature=b58d29014a6a4db46f79b7bf06f9bada008a2a48c1ef9cb6fb639f0d602d8d19&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject",
        "createdAt": "2025-05-13T09:59:48.668Z",
        "expiresAt": "2025-05-20T09:59:48.667Z",
        "bucket": "test",
        "type": "DOCUMENT",
        "venueId": "ff81d498-b7a0-493c-8a49-f008d7625fbc",
        "venueDecorationId": null,
        "eventPreferenceId": null,
        "profileId": null,
        "directMessageId": null,
        "nationalIdCardId": null,
        "tradeLicenseCardId": null,
        "groupMessageId": null,
        "worksId": null,
        "serviceProviderTypeId": null
      }
    }
  ],
  "upcomingEvents": [],
  "eventServices": [
    {
      "id": "d761827b-a030-4480-8b4b-b880d7689e11",
      "name": "Photographers"
    },
    {
      "id": "51312e3d-474c-4eb0-885b-81571a110104",
      "name": "Videographers "
    },
    {
      "id": "67ae06a4-f8e4-4856-a470-3c5df9caa9f4",
      "name": "Musicians/Bands"
    },
    {
      "id": "0acf5b00-1d5c-46f9-a0d3-b3d2b03ec156",
      "name": "DJs"
    },
    {
      "id": "cecdde43-50c0-4fcb-b90a-48fa3468c4e4",
      "name": "Florists "
    },
    {
      "id": "42bfdecf-91a2-43f7-9b6a-a5e8a99d8cc3",
      "name": "Event Decorators"
    },
    {
      "id": "27de3484-2ca9-4fc7-a825-f7940e820334",
      "name": "Security Services "
    },
    {
      "id": "f7bafa1b-f214-4b60-91f3-6023bde1e7d9",
      "name": "Lighting Specialists "
    }
  ]
}
*/
