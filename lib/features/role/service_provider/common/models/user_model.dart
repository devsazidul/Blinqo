class SpUser {
    SpUser({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        required this.role,
        required this.isVerified,
        required this.createdAt,
        required this.updatedAt,
        required this.profile,
    });

    final String? id;
    final String? email;
    final String? phone;
    final String? name;
    final List<String> role;
    final bool? isVerified;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Profile? profile;

    SpUser copyWith({
        String? id,
        String? email,
        String? phone,
        String? name,
        List<String>? role,
        bool? isVerified,
        DateTime? createdAt,
        DateTime? updatedAt,
        Profile? profile,
    }) {
        return SpUser(
            id: id ?? this.id,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            name: name ?? this.name,
            role: role ?? this.role,
            isVerified: isVerified ?? this.isVerified,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            profile: profile ?? this.profile,
        );
    }

    factory SpUser.fromJson(Map<String, dynamic> json){ 
        return SpUser(
            id: json["id"],
            email: json["email"],
            phone: json["phone"],
            name: json["name"],
            role: json["role"] == null ? [] : List<String>.from(json["role"]!.map((x) => x)),
            isVerified: json["isVerified"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "role": role.map((x) => x).toList(),
        "isVerified": isVerified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
    };

}

class Profile {
    Profile({
        required this.id,
        required this.userId,
        required this.name,
        required this.gender,
        required this.imageId,
        required this.location,
        required this.coverPhotoId,
        required this.profession,
        required this.description,
        required this.experience,
        required this.createdAt,
        required this.updatedAt,
        required this.isPro,
        required this.active,
        required this.enableNotification,
        required this.verificationSubmissionId,
        required this.groupMessageId,
        required this.serviceProviderRole,
        required this.image,
        required this.coverPhoto,
        required this.eventPreference,
    });

    final String? id;
    final String? userId;
    final String? name;
    final String? gender;
    final String? imageId;
    final String? location;
    final String? coverPhotoId;
    final dynamic profession;
    final String? description;
    final int? experience;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isPro;
    final bool? active;
    final bool? enableNotification;
    final dynamic verificationSubmissionId;
    final dynamic groupMessageId;
    final String? serviceProviderRole;
    final CoverPhoto? image;
    final CoverPhoto? coverPhoto;
    final List<EventPreference> eventPreference;

    Profile copyWith({
        String? id,
        String? userId,
        String? name,
        String? gender,
        String? imageId,
        String? location,
        String? coverPhotoId,
        String? profession,
        String? description,
        int? experience,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? isPro,
        bool? active,
        bool? enableNotification,
        String? verificationSubmissionId,
        String? groupMessageId,
        String? serviceProviderRole,
        CoverPhoto? image,
        CoverPhoto? coverPhoto,
        List<EventPreference>? eventPreference,
    }) {
        return Profile(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            gender: gender ?? this.gender,
            imageId: imageId ?? this.imageId,
            location: location ?? this.location,
            coverPhotoId: coverPhotoId ?? this.coverPhotoId,
            profession: profession ?? this.profession,
            description: description ?? this.description,
            experience: experience ?? this.experience,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            isPro: isPro ?? this.isPro,
            active: active ?? this.active,
            enableNotification: enableNotification ?? this.enableNotification,
            verificationSubmissionId: verificationSubmissionId ?? this.verificationSubmissionId,
            groupMessageId: groupMessageId ?? this.groupMessageId,
            serviceProviderRole: serviceProviderRole ?? this.serviceProviderRole,
            image: image ?? this.image,
            coverPhoto: coverPhoto ?? this.coverPhoto,
            eventPreference: eventPreference ?? this.eventPreference,
        );
    }

    factory Profile.fromJson(Map<String, dynamic> json){ 
        return Profile(
            id: json["id"],
            userId: json["userId"],
            name: json["name"],
            gender: json["gender"],
            imageId: json["imageId"],
            location: json["location"],
            coverPhotoId: json["coverPhotoId"],
            profession: json["profession"],
            description: json["description"],
            experience: json["experience"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            isPro: json["isPro"],
            active: json["active"],
            enableNotification: json["enableNotification"],
            verificationSubmissionId: json["verificationSubmissionId"],
            groupMessageId: json["groupMessageId"],
            serviceProviderRole: json["serviceProviderRole"],
            image: json["image"] == null ? null : CoverPhoto.fromJson(json["image"]),
            coverPhoto: json["coverPhoto"] == null ? null : CoverPhoto.fromJson(json["coverPhoto"]),
            eventPreference: json["eventPreference"] == null ? [] : List<EventPreference>.from(json["eventPreference"]!.map((x) => EventPreference.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "gender": gender,
        "imageId": imageId,
        "location": location,
        "coverPhotoId": coverPhotoId,
        "profession": profession,
        "description": description,
        "experience": experience,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isPro": isPro,
        "active": active,
        "enableNotification": enableNotification,
        "verificationSubmissionId": verificationSubmissionId,
        "groupMessageId": groupMessageId,
        "serviceProviderRole": serviceProviderRole,
        "image": image?.toJson(),
        "coverPhoto": coverPhoto?.toJson(),
        "eventPreference": eventPreference.map((x) => x.toJson()).toList(),
    };

}

class CoverPhoto {
    CoverPhoto({
        required this.path,
    });

    final String? path;

    CoverPhoto copyWith({
        String? path,
    }) {
        return CoverPhoto(
            path: path ?? this.path,
        );
    }

    factory CoverPhoto.fromJson(Map<String, dynamic> json){ 
        return CoverPhoto(
            path: json["path"],
        );
    }

    Map<String, dynamic> toJson() => {
        "path": path,
    };

}

class EventPreference {
    EventPreference({
        required this.id,
        required this.name,
        required this.avatar,
    });

    final String? id;
    final String? name;
    final CoverPhoto? avatar;

    EventPreference copyWith({
        String? id,
        String? name,
        CoverPhoto? avatar,
    }) {
        return EventPreference(
            id: id ?? this.id,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
        );
    }

    factory EventPreference.fromJson(Map<String, dynamic> json){ 
        return EventPreference(
            id: json["id"],
            name: json["name"],
            avatar: json["avatar"] == null ? null : CoverPhoto.fromJson(json["avatar"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar?.toJson(),
    };

}

/*
{
	"id": "b7b6e379-df13-4f30-86a4-a4be31c78619",
	"email": "test@yopmail.com",
	"phone": "+8801988799878",
	"name": "test1234",
	"role": [
		"SERVICE_PROVIDER"
	],
	"isVerified": true,
	"createdAt": "2025-05-12T05:28:28.824Z",
	"updatedAt": "2025-05-12T06:30:18.002Z",
	"profile": {
		"id": "36fdbce2-7356-42e2-a651-92343ad6e341",
		"userId": "b7b6e379-df13-4f30-86a4-a4be31c78619",
		"name": "test",
		"gender": "OTHER",
		"imageId": "c48c8500-1f7c-471c-b30b-826087c0ebca",
		"location": "Bhairab",
		"coverPhotoId": "c305666d-0577-453c-9562-70ec7c5d9401",
		"profession": null,
		"description": "I am test user",
		"experience": 2,
		"createdAt": "2025-05-12T06:08:59.040Z",
		"updatedAt": "2025-05-12T06:30:18.002Z",
		"isPro": false,
		"active": false,
		"enableNotification": true,
		"verificationSubmissionId": null,
		"groupMessageId": null,
		"serviceProviderRole": "PHOTOGRAPHER",
		"image": {
			"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/18.jpg-0172d723-ca3a-4a8c-b149-b46d0dcd09ba?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250512%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250512T060858Z&X-Amz-Expires=604800&X-Amz-Signature=f353fd2fdb3b045705bc24f49bb8f0e75193055cfd5424a187d68f02a4dd5820&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
		},
		"coverPhoto": {
			"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/24.jpg-2a046845-31cc-4d14-8d10-b8843633bfbc?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250512%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250512T060859Z&X-Amz-Expires=604800&X-Amz-Signature=c0c27ccbe3a3a0f4da5f34e7b9547acfc50b027838dd0e65b052f61d4ba0f67c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
		},
		"eventPreference": [
			{
				"id": "0865c05b-9cf0-4fc6-b8d1-7877a6418a99",
				"name": "Charity Events",
				"avatar": {
					"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/charity_events.png-107497e0-eaee-4640-ab37-ad045e00893a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250512%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250512T055826Z&X-Amz-Expires=604800&X-Amz-Signature=d6f1aa7d3a7596df232c6a7a63df36f0110caee62e821c7fd623d08255b405b6&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
				}
			},
			{
				"id": "0132f232-da7a-49ca-a67d-28dea3ad8a29",
				"name": "Concerts",
				"avatar": {
					"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/concerts.png-52768b99-3531-4634-95d0-f782eca1e1c3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250512%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250512T055926Z&X-Amz-Expires=604800&X-Amz-Signature=1d2b7761e35d7f370a3a62dce766ecf1c75f1231d11eaea64da80089ff56e479&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
				}
			},
			{
				"id": "84937f02-c7a4-485d-970b-254ce232baa2",
				"name": "Corporate Events",
				"avatar": {
					"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/corporate_events.png-a20a723a-afd9-4610-bcf7-6b7948617185?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250512%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250512T060030Z&X-Amz-Expires=604800&X-Amz-Signature=0f6fca9637e32f162b2c4b3e714fe1eb49a1563a3f5fc51f5d9895a6d0a11041&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
				}
			},
			{
				"id": "ea5f4fbc-b138-4b7b-acd3-dd94813882d8",
				"name": "Private Party",
				"avatar": {
					"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/private_party.png-615c187e-9f96-4b72-9c99-fc5bdbcf42bc?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250512%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250512T060248Z&X-Amz-Expires=604800&X-Amz-Signature=6e206c9788f1fe47cbb1a3990ee9c0da25ba12d8536afed1e04c0c9e161c3edf&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
				}
			}
		]
	}
}*/