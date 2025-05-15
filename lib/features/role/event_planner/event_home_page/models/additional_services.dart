import 'dart:convert';

AdditionalService additionalServiceFromJson(String str) => AdditionalService.fromJson(json.decode(str));

String additionalServiceToJson(AdditionalService data) => json.encode(data.toJson());

class AdditionalService {
  List<Datum> data;
  String message;
  int statusCode;
  bool success;

  AdditionalService({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  factory AdditionalService.fromJson(Map<String, dynamic> json) => AdditionalService(
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
  String name;
  Avatar avatar;

  Datum({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    avatar: Avatar.fromJson(json["avatar"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar.toJson(),
  };
}

class Avatar {
  String path;

  Avatar({
    required this.path,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
  };
}
