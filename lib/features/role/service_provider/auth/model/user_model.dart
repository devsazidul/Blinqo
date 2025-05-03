class UserModel {
  final String id;
  final String email;
  final List<String> role;
  final bool isVerified;
  final String profileId;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    required this.profileId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] != null ? List<String>.from(json['role']) : [],
      isVerified: json['isVerified'] ?? false,
      profileId: json['profileId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'isVerified': isVerified,
      'profileId': profileId,
    };
  }
}
