class UserModel {
  final String id;
  final String email;
  final List<String> roles;
  final bool isVerified;
  final String profileId;
  final bool isProfileCreated;

  UserModel({
    required this.id,
    required this.email,
    required this.roles,
    required this.isVerified,
    required this.profileId,
    required this.isProfileCreated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      roles: json['roles'] != null ? List<String>.from(json['roles']) : [],
      isVerified: json['isVerified'] ?? false,
      profileId: json['profileId'] ?? '',
      isProfileCreated: json['isProfileCreated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'roles': roles,
      'isVerified': isVerified,
      'profileId': profileId,
      'isProfileCreated': isProfileCreated,
    };
  }
}
