import 'package:blinqo/features/role/service_provider/common/models/profile_info_model.dart';

class UserInfoModel {
  String? id;
  String? email;
  String? phone;
  String? name;
  List<String>? role;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  ProfileInfoModel? profile;

  UserInfoModel({
    this.id,
    this.email,
    this.phone,
    this.name,
    this.role,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    role = json['role'] != null ? json['role'].cast<String>() : [];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profile =
        json['profile'] != null
            ? ProfileInfoModel.fromJson(json['profile'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['role'] = role;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}
