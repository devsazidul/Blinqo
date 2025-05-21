import 'package:blinqo/core/common/models/image_model.dart';

// AdditionalService additionalServiceFromJson(String str) => AdditionalService.fromJson(json.decode(str));

// String additionalServiceToJson(AdditionalService data) => json.encode(data.toJson());

class ServiceProviderTypeModel {
  final String? id;
  final String? name;
  final ImageModel? avatar;

  ServiceProviderTypeModel({this.id, this.name, this.avatar});

  factory ServiceProviderTypeModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderTypeModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      avatar:
          json["avatar"] == null ? null : ImageModel.fromJson(json["avatar"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar?.toJson(),
  };
}
