import 'package:blinqo/core/common/models/image_model.dart';

class ServiceProviderModel {
  ServiceProviderModel({
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
    required this.basePrice,
    required this.susPend,
    required this.user,
    required this.serviceType,
    required this.image,
  });

  final String? id;
  final String? userId;
  final String? name;
  final String? gender;
  final String? imageId;
  final String? location;
  final String? coverPhotoId;
  final String? profession;
  final String? description;
  final int? experience;
  final String? createdAt;
  final String? updatedAt;
  final bool? isPro;
  final bool? active;
  final bool? enableNotification;
  final String? verificationSubmissionId;
  final String? groupMessageId;
  final int? basePrice;
  final bool? susPend;
  final User? user;
  final List<ServiceType> serviceType;
  final ImageModel? image;

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
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
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      isPro: json["isPro"],
      active: json["active"],
      enableNotification: json["enableNotification"],
      verificationSubmissionId: json["verificationSubmissionId"],
      groupMessageId: json["groupMessageId"],
      basePrice: json["basePrice"],
      susPend: json["susPend"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      serviceType:
          json["serviceType"] == null
              ? []
              : List<ServiceType>.from(
                json["serviceType"]!.map((x) => ServiceType.fromJson(x)),
              ),
      image: json["image"] == null ? null : ImageModel.fromJson(json["image"]),
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isPro": isPro,
    "active": active,
    "enableNotification": enableNotification,
    "verificationSubmissionId": verificationSubmissionId,
    "groupMessageId": groupMessageId,
    "basePrice": basePrice,
    "susPend": susPend,
    "user": user?.toJson(),
    "serviceType": serviceType.map((x) => x.toJson()).toList(),
    "image": image?.toJson(),
  };
}

class Image {
  Image({required this.path});

  final String? path;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(path: json["path"]);
  }

  Map<String, dynamic> toJson() => {"path": path};
}

class ServiceType {
  ServiceType({required this.id, required this.name});

  final String? id;
  final String? name;

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class User {
  User({
    required this.role,
    required this.name,
    required this.isVerified,
    required this.createdAt,
    required this.email,
  });

  final List<String> role;
  final String? name;
  final bool? isVerified;
  final DateTime? createdAt;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      role:
          json["role"] == null
              ? []
              : List<String>.from(json["role"]!.map((x) => x)),
      name: json["name"],
      isVerified: json["isVerified"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role.map((x) => x).toList(),
    "name": name,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "email": email,
  };
}

/*
{
	"id": "24318b9f-2196-4b47-ad26-66c838ef5640",
	"userId": "88d6ff48-b71b-45c0-8550-495a1612fa70",
	"name": "Jayed Bin Nazir2",
	"gender": "OTHER",
	"imageId": "78792de1-eb36-4da0-89fe-f8a20d05a2ad",
	"location": "123 Main St, Anytown, CA 90210",
	"coverPhotoId": "6bdc5480-350b-4579-adb7-807603831858",
	"profession": null,
	"description": "123 Main St, Anytown, CA 90210",
	"experience": 5,
	"createdAt": "2025-05-15T04:55:54.479Z",
	"updatedAt": "2025-05-15T09:24:50.431Z",
	"isPro": false,
	"active": false,
	"enableNotification": true,
	"verificationSubmissionId": "1037e367-c9ec-45b9-9472-2ee2f377bba5",
	"groupMessageId": null,
	"basePrice": 0,
	"susPend": false,
	"user": {
		"role": [
			"SERVICE_PROVIDER"
		],
		"name": "John Doe",
		"isVerified": true,
		"createdAt": "2025-05-15T04:45:04.993Z",
		"email": "xoxibi9095@jazipo.com"
	},
	"serviceType": [
		{
			"id": "d761827b-a030-4480-8b4b-b880d7689e11",
			"name": "Photographers"
		}
	],
	"image": {
		"path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/light1-min.png-8a90fc89-95f4-4e79-9669-2709265c0962?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250515%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250515T045553Z&X-Amz-Expires=604800&X-Amz-Signature=068e98f825fe0f0f628f645e38f6c619260874d47470e7aba4dcc340579f2923&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
	}
}*/
