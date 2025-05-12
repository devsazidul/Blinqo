class VenueOwnerUserData {
  final String id;
  final String email;
  final String phone;
  final String name;
  final List<String> role;
  final bool isVerified;
  final String createdAt;
  final String updatedAt;
  final UserProfile? profile;

  VenueOwnerUserData({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory VenueOwnerUserData.fromJson(Map<String, dynamic> json) {
    return VenueOwnerUserData(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      role: List<String>.from(json['role']),
      isVerified: json['isVerified'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      profile:
          json['profile'] != null
              ? UserProfile.fromJson(json['profile'])
              : null,
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
      'profile': profile?.toJson(),
    };
  }
}

class UserProfile {
  final String id;
  final String userId;
  final String name;
  final String gender;
  final String imageId;
  final String location;
  final String? coverPhotoId;
  final String? profession;
  final String? description;
  final String? experience;
  final String createdAt;
  final String updatedAt;
  final bool isPro;
  final bool active;
  final bool enableNotification;
  final String? verificationSubmissionId;
  final String? groupMessageId;
  final String? serviceProviderRole;
  final UserProfileImage? image;
  final String? coverPhoto;
  final List<dynamic> eventPreference;

  UserProfile({
    required this.id,
    required this.userId,
    required this.name,
    required this.gender,
    required this.imageId,
    required this.location,
    this.coverPhotoId,
    this.profession,
    this.description,
    this.experience,
    required this.createdAt,
    required this.updatedAt,
    required this.isPro,
    required this.active,
    required this.enableNotification,
    this.verificationSubmissionId,
    this.groupMessageId,
    this.serviceProviderRole,
    this.image,
    this.coverPhoto,
    required this.eventPreference,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      imageId: json['imageId'] as String,
      location: json['location'] as String,
      coverPhotoId: json['coverPhotoId'] as String?,
      profession: json['profession'] as String?,
      description: json['description'] as String?,
      experience: json['experience'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isPro: json['isPro'] as bool,
      active: json['active'] as bool,
      enableNotification: json['enableNotification'] as bool,
      verificationSubmissionId: json['verificationSubmissionId'] as String?,
      groupMessageId: json['groupMessageId'] as String?,
      serviceProviderRole: json['serviceProviderRole'] as String?,
      image:
          json['image'] != null
              ? UserProfileImage.fromJson(json['image'])
              : null,
      coverPhoto: json['coverPhoto'] as String?,
      eventPreference: List.from(json['eventPreference']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'gender': gender,
      'imageId': imageId,
      'location': location,
      'coverPhotoId': coverPhotoId,
      'profession': profession,
      'description': description,
      'experience': experience,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isPro': isPro,
      'active': active,
      'enableNotification': enableNotification,
      'verificationSubmissionId': verificationSubmissionId,
      'groupMessageId': groupMessageId,
      'serviceProviderRole': serviceProviderRole,
      'image': image?.toJson(),
      'coverPhoto': coverPhoto,
      'eventPreference': eventPreference,
    };
  }
}

class UserProfileImage {
  final String path;

  UserProfileImage({required this.path});

  factory UserProfileImage.fromJson(Map<String, dynamic> json) {
    return UserProfileImage(path: json['path'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'path': path};
  }
}
