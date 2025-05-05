class UserEvenModel {
  final String id;
  final String email;
  final List<String> roles;
  final bool isVerified;
  final String profileId;

  UserEvenModel({
    required this.id,
    required this.email,
    required this.roles,
    required this.isVerified,
    required this.profileId,
  });

  factory UserEvenModel.fromJson(Map<String, dynamic> json) {
    return UserEvenModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      roles: json['roles'] != null ? List<String>.from(json['roles']) : [],
      isVerified: json['isVerified'] ?? false,
      profileId: json['profileId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'roles': roles,
      'isVerified': isVerified,
      'profileId': profileId,
    };
  }
}
