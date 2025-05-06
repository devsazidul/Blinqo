import 'package:blinqo/features/role/service_provider/common/models/user_profile_model.dart';

class UserInfoModel {
  final String id;
  final String email;
  final String phone;
  final String name;
  final List<String> role;
  final bool isVerified;
  final String createdAt;
  final String updatedAt;
  final UserProfileModel profile;

  UserInfoModel({
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

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] != null ? List<String>.from(json['role']) : [],
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      profile:
          json['profile'] != null
              ? UserProfileModel.fromJson(json['profile'])
              : UserProfileModel(
                id: '',
                userId: '',
                name: '',
                gender: '',
                imageId: '',
                location: '',
                coverPhotoId: '',
                description: '',
                experience: 0,
                createdAt: '',
                updatedAt: '',
                isPro: false,
                active: false,
                enableNotification: false,
                serviceProviderRole: '',
                image: ProfileImage(path: ''),
              ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'role': role,
      'isVerified': isVerified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'profile': profile.toJson(),
    };
  }
}
