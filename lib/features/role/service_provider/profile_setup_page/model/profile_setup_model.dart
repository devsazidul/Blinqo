class ProfileSetupModel {
    ProfileSetupModel({
        required this.profile,
        required this.accessToken,
    });

    final Profile? profile;
    final String? accessToken;

    ProfileSetupModel copyWith({
        Profile? profile,
        String? accessToken,
    }) {
        return ProfileSetupModel(
            profile: profile ?? this.profile,
            accessToken: accessToken ?? this.accessToken,
        );
    }

    factory ProfileSetupModel.fromJson(Map<String, dynamic> json){ 
        return ProfileSetupModel(
            profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
            accessToken: json["access_token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "profile": profile?.toJson(),
        "access_token": accessToken,
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
        required this.user,
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
    final User? user;

    Profile copyWith({
        String? id,
        String? userId,
        String? name,
        String? gender,
        String? imageId,
        String? location,
        String? coverPhotoId,
        dynamic? profession,
        String? description,
        int? experience,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? isPro,
        bool? active,
        bool? enableNotification,
        dynamic? verificationSubmissionId,
        dynamic? groupMessageId,
        String? serviceProviderRole,
        User? user,
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
            user: user ?? this.user,
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
            user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "user": user?.toJson(),
    };

}

class User {
    User({
        required this.id,
        required this.email,
        required this.phone,
        required this.password,
        required this.name,
        required this.role,
        required this.isVerified,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? email;
    final String? phone;
    final String? password;
    final String? name;
    final List<String> role;
    final bool? isVerified;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    User copyWith({
        String? id,
        String? email,
        String? phone,
        String? password,
        String? name,
        List<String>? role,
        bool? isVerified,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return User(
            id: id ?? this.id,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            password: password ?? this.password,
            name: name ?? this.name,
            role: role ?? this.role,
            isVerified: isVerified ?? this.isVerified,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            email: json["email"],
            phone: json["phone"],
            password: json["password"],
            name: json["name"],
            role: json["role"] == null ? [] : List<String>.from(json["role"]!.map((x) => x)),
            isVerified: json["isVerified"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "password": password,
        "name": name,
        "role": role.map((x) => x).toList(),
        "isVerified": isVerified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };

}

/*
{
	"profile": {
		"id": "99b6695f-299a-456d-81fb-f6390530a4bc",
		"userId": "4144186c-b45c-402f-88cd-3da963bd7ffe",
		"name": "test1000",
		"gender": "OTHER",
		"imageId": "8d8844ce-eaba-4200-92b4-3fbf837fc891",
		"location": "123 Main St, Anytown, CA 90210",
		"coverPhotoId": "fb000219-534e-4257-8dc8-708dad32d043",
		"profession": null,
		"description": "This is Description",
		"experience": 1,
		"createdAt": "2025-05-12T10:57:21.834Z",
		"updatedAt": "2025-05-12T10:57:21.834Z",
		"isPro": false,
		"active": false,
		"enableNotification": true,
		"verificationSubmissionId": null,
		"groupMessageId": null,
		"serviceProviderRole": "CATERING",
		"user": {
			"id": "4144186c-b45c-402f-88cd-3da963bd7ffe",
			"email": "test1@yopmail.com",
			"phone": "+8801845788787",
			"password": "$2b$10$2MMSyhJJsWIE333nWW/Y1ucDGpBdpdd5IWYiHQjqGUu3vgeW9z6Mi",
			"name": "Test 1",
			"role": [
				"SERVICE_PROVIDER"
			],
			"isVerified": true,
			"createdAt": "2025-05-12T08:49:26.051Z",
			"updatedAt": "2025-05-12T08:51:43.097Z"
		}
	},
	"access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0MTQ0MTg2Yy1iNDVjLTQwMmYtODhjZC0zZGE5NjNiZDdmZmUiLCJlbWFpbCI6InRlc3QxQHlvcG1haWwuY29tIiwicm9sZSI6WyJTRVJWSUNFX1BST1ZJREVSIl0sImlzVmVyaWZpZWQiOnRydWUsInByb2ZpbGVJZCI6Ijk5YjY2OTVmLTI5OWEtNDU2ZC04MWZiLWY2MzkwNTMwYTRiYyIsImlhdCI6MTc0NzA0NzQ0MSwiZXhwIjoxNzQ3NjUyMjQxfQ.4HDoWEeM2w-bCrXOxhFp1SjFiaaYx3x1IqlM-91Fc5g"
}*/