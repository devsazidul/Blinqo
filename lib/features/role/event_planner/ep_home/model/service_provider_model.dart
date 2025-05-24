import 'package:blinqo/core/common/models/image_model.dart';

class EpServiceProviderModel {
  // properties
  String? id;
  String? userId;
  String? name;
  String? gender;
  String? imageId;
  String? location;
  String? coverPhotoId;
  String? profession;
  String? description;
  int? experience;
  String? createdAt;
  String? updatedAt;
  bool? isPro;
  bool? active;
  bool? enableNotification;
  String? verificationSubmissionId;
  String? groupMessageId;
  int? basePrice;
  bool? susPend;
  EpSpUser? user;
  List<EpServiceType>? serviceType;
  ImageModel? image;

  // constructor
  EpServiceProviderModel({
    this.id,
    this.userId,
    this.name,
    this.gender,
    this.imageId,
    this.location,
    this.coverPhotoId,
    this.profession,
    this.description,
    this.experience,
    this.createdAt,
    this.updatedAt,
    this.isPro,
    this.active,
    this.enableNotification,
    this.verificationSubmissionId,
    this.groupMessageId,
    this.basePrice,
    this.susPend,
    this.user,
    this.serviceType,
    this.image,
  });

  // from json
  factory EpServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return EpServiceProviderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      imageId: json['imageId'] ?? '',
      location: json['location'] ?? '',
      coverPhotoId: json['coverPhotoId'] ?? '',
      profession: json['profession'] ?? '',
      description: json['description'] ?? '',
      experience: json['experience'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      isPro: json['isPro'] ?? false,
      active: json['active'] ?? false,
      enableNotification: json['enableNotification'] ?? false,
      verificationSubmissionId: json['verificationSubmissionId'] ?? '',
      groupMessageId: json['groupMessageId'] ?? '',
      basePrice: json['basePrice'] ?? 0,
      susPend: json['susPend'] ?? false,
      user: json['user'] != null ? EpSpUser.fromJson(json['user']) : null,
      serviceType:
          json['serviceType'] != null
              ? List<EpServiceType>.from(
                json['serviceType'].map((x) => EpServiceType.fromJson(x)),
              )
              : null,
      image: json['image'] != null ? ImageModel.fromJson(json['image']) : null,
    );
  }

  // to json
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
    "serviceType": serviceType?.map((x) => x.toJson()).toList(),
    "image": image?.toJson(),
  };
}

class EpSpUser {
  List<String>? role;
  String? name;
  bool? isVerified;
  String? createdAt;
  String? email;

  EpSpUser({this.role, this.name, this.isVerified, this.createdAt, this.email});

  factory EpSpUser.fromJson(Map<String, dynamic> json) {
    return EpSpUser(
      role: json['role'] != null ? List<String>.from(json['role']) : null,
      name: json['name'] ?? '',
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role,
    "name": name,
    "isVerified": isVerified,
    "createdAt": createdAt,
    "email": email,
  };
}

class EpServiceType {
  String? id;
  String? name;

  EpServiceType({this.id, this.name});

  factory EpServiceType.fromJson(Map<String, dynamic> json) {
    return EpServiceType(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

/*
{
  "data": [
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
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/light1-min.png-8a90fc89-95f4-4e79-9669-2709265c0962?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250520%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250520T050000Z&X-Amz-Expires=604800&X-Amz-Signature=6f0fa5d08d6edea54e20ec4ab6d2396d38ca30f41b22f61cfee54f4646fc3440&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
      }
    },
    {
      "id": "36fdbce2-7356-42e2-a651-92343ad6e341",
      "userId": "b7b6e379-df13-4f30-86a4-a4be31c78619",
      "name": "test",
      "gender": "OTHER",
      "imageId": "c48c8500-1f7c-471c-b30b-826087c0ebca",
      "location": "Dhaka",
      "coverPhotoId": "c305666d-0577-453c-9562-70ec7c5d9401",
      "profession": null,
      "description": "Test description",
      "experience": 2,
      "createdAt": "2025-05-12T06:08:59.040Z",
      "updatedAt": "2025-05-21T11:59:04.358Z",
      "isPro": false,
      "active": false,
      "enableNotification": true,
      "verificationSubmissionId": null,
      "groupMessageId": null,
      "basePrice": 0,
      "susPend": false,
      "user": {
        "role": [
          "SERVICE_PROVIDER"
        ],
        "name": "Mr Test",
        "isVerified": true,
        "createdAt": "2025-05-12T05:28:28.824Z",
        "email": "test@yopmail.com"
      },
      "serviceType": [
        {
          "id": "d761827b-a030-4480-8b4b-b880d7689e11",
          "name": "Photographers"
        },
        {
          "id": "51312e3d-474c-4eb0-885b-81571a110104",
          "name": "Videographers "
        },
        {
          "id": "cecdde43-50c0-4fcb-b90a-48fa3468c4e4",
          "name": "Florists "
        },
        {
          "id": "27de3484-2ca9-4fc7-a825-f7940e820334",
          "name": "Security Services "
        }
      ],
      "image": {
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/18.jpg-0172d723-ca3a-4a8c-b149-b46d0dcd09ba?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250517%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250517T063000Z&X-Amz-Expires=604800&X-Amz-Signature=6327d32ef9b5ee57a63bef24b9b66a7bace01ba7dc97298311ce0773a72eb7ec&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
      }
    }
  ],
  "message": "Service provider profile fetched successfully",
  "statusCode": 200,
  "success": true
}
*/
