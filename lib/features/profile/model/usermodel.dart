class UserInfo {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  UserInfo({this.statusCode, this.success, this.message, this.data});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data:
          json['data'] != null
              ? Data.fromJson(json['data'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? phone;
  String? name;
  List<String>? role;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  Profile? profile;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      role: (json['role'] as List<dynamic>?)?.cast<String>(),
      isVerified: json['isVerified'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      profile:
          json['profile'] != null
              ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class Profile {
  String? id;
  String? userId;
  String? name;
  String? gender;
  String? imageId;
  String? location;
  String? coverPhotoId;
  String? profession;
  String? description;
  String? experience;
  String? createdAt;
  String? updatedAt;
  bool? isPro;
  bool? active;
  bool? enableNotification;
  String? verificationSubmissionId;
  String? groupMessageId;
  String? serviceProviderRole;
  Image? image;
  String? coverPhoto;
  List<EventPreference>? eventPreference;

  Profile({
    this.id,
    this.userId,
    this.name,
    this.gender,
    this.imageId,
    this.location,
    this.coverPhotoId,
    this.profession,
    this.description,
    this.experience,
    this.createdAt,
    this.updatedAt,
    this.isPro,
    this.active,
    this.enableNotification,
    this.verificationSubmissionId,
    this.groupMessageId,
    this.serviceProviderRole,
    this.image,
    this.coverPhoto,
    this.eventPreference,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      imageId: json['imageId'] as String?,
      location: json['location'] as String?,
      coverPhotoId: json['coverPhotoId'] as String?,
      profession: json['profession'] as String?,
      description: json['description'] as String?,
      experience: json['experience'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isPro: json['isPro'] as bool?,
      active: json['active'] as bool?,
      enableNotification: json['enableNotification'] as bool?,
      verificationSubmissionId: json['verificationSubmissionId'] as String?,
      groupMessageId: json['groupMessageId'] as String?,
      serviceProviderRole: json['serviceProviderRole'] as String?,
      image:
          json['image'] != null
              ? Image.fromJson(json['image'] as Map<String, dynamic>)
              : null,
      coverPhoto: json['coverPhoto'] as String?,
      eventPreference:
          (json['eventPreference'] as List<dynamic>?)
              ?.map((v) => EventPreference.fromJson(v as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['gender'] = gender;
    data['imageId'] = imageId;
    data['location'] = location;
    data['coverPhotoId'] = coverPhotoId;
    data['profession'] = profession;
    data['description'] = description;
    data['experience'] = experience;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isPro'] = isPro;
    data['active'] = active;
    data['enableNotification'] = enableNotification;
    data['verificationSubmissionId'] = verificationSubmissionId;
    data['groupMessageId'] = groupMessageId;
    data['serviceProviderRole'] = serviceProviderRole;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['coverPhoto'] = coverPhoto;
    if (eventPreference != null) {
      data['eventPreference'] =
          eventPreference!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? path;

  Image({this.path});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(path: json['path'] as String?);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['path'] = path;
    return data;
  }
}

class EventPreference {
  String? id;
  String? name;
  Image? avatar;

  EventPreference({this.id, this.name, this.avatar});

  factory EventPreference.fromJson(Map<String, dynamic> json) {
    return EventPreference(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar:
          json['avatar'] != null
              ? Image.fromJson(json['avatar'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    return data;
  }
}
