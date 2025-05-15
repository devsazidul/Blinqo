import 'dart:convert';

ServiceUserModel serviceUserModelFromJson(String str) => ServiceUserModel.fromJson(json.decode(str));

String serviceUserModelToJson(ServiceUserModel data) => json.encode(data.toJson());

class ServiceUserModel {
  List<Datum> data;
  String message;
  int statusCode;
  bool success;

  ServiceUserModel({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  factory ServiceUserModel.fromJson(Map<String, dynamic> json) => ServiceUserModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    statusCode: json["statusCode"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "statusCode": statusCode,
    "success": success,
  };
}

class Datum {
  String id;
  String userId;
  String name;
  String gender;
  String imageId;
  String location;
  String coverPhotoId;
  dynamic profession;
  String description;
  int experience;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPro;
  bool active;
  bool enableNotification;
  String verificationSubmissionId;
  dynamic groupMessageId;
  int basePrice;
  User user;
  List<ServiceType> serviceType;
  ServiceImage image; // Renamed from Image to ServiceImage

  Datum({
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
    required this.user,
    required this.serviceType,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    isPro: json["isPro"],
    active: json["active"],
    enableNotification: json["enableNotification"],
    verificationSubmissionId: json["verificationSubmissionId"],
    groupMessageId: json["groupMessageId"],
    basePrice: json["basePrice"],
    user: User.fromJson(json["user"]),
    serviceType: List<ServiceType>.from(json["serviceType"].map((x) => ServiceType.fromJson(x))),
    image: ServiceImage.fromJson(json["image"]), // Update to ServiceImage
  );

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
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isPro": isPro,
    "active": active,
    "enableNotification": enableNotification,
    "verificationSubmissionId": verificationSubmissionId,
    "groupMessageId": groupMessageId,
    "basePrice": basePrice,
    "user": user.toJson(),
    "serviceType": List<dynamic>.from(serviceType.map((x) => x.toJson())),
    "image": image.toJson(), // Update to ServiceImage
  };
}

class ServiceImage {  // Renamed from Image to ServiceImage
  String path;

  ServiceImage({
    required this.path,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
  };
}

class ServiceType {
  String id;
  String name;

  ServiceType({
    required this.id,
    required this.name,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class User {
  List<String> role;
  String name;
  bool isVerified;
  DateTime createdAt;
  String email;

  User({
    required this.role,
    required this.name,
    required this.isVerified,
    required this.createdAt,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    role: List<String>.from(json["role"].map((x) => x)),
    name: json["name"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "role": List<dynamic>.from(role.map((x) => x)),
    "name": name,
    "isVerified": isVerified,
    "createdAt": createdAt.toIso8601String(),
    "email": email,
  };
}
