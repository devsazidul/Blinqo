class UserProfileModel {
  final String id;
  final String userId;
  final String name;
  final String gender;
  final String imageId;
  final String location;
  final String coverPhotoId;
  final String? profession;
  final String description;
  final int experience;
  final String createdAt;
  final String updatedAt;
  final bool isPro;
  final bool active;
  final bool enableNotification;
  final dynamic verificationSubmissionId;
  final dynamic groupMessageId;
  final String serviceProviderRole;
  final ProfileImage image;

  UserProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.gender,
    required this.imageId,
    required this.location,
    required this.coverPhotoId,
    this.profession,
    required this.description,
    required this.experience,
    required this.createdAt,
    required this.updatedAt,
    required this.isPro,
    required this.active,
    required this.enableNotification,
    this.verificationSubmissionId,
    this.groupMessageId,
    required this.serviceProviderRole,
    required this.image,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      gender: json['gender'],
      imageId: json['imageId'],
      location: json['location'],
      coverPhotoId: json['coverPhotoId'],
      profession: json['profession'],
      description: json['description'],
      experience: json['experience'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isPro: json['isPro'],
      active: json['active'],
      enableNotification: json['enableNotification'],
      verificationSubmissionId: json['verificationSubmissionId'],
      groupMessageId: json['groupMessageId'],
      serviceProviderRole: json['serviceProviderRole'],
      image: ProfileImage.fromJson(json['image']),
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
      'image': image.toJson(),
    };
  }
}

class ProfileImage {
  final String path;

  ProfileImage({required this.path});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(path: json['path']);
  }

  Map<String, dynamic> toJson() {
    return {'path': path};
  }
}
