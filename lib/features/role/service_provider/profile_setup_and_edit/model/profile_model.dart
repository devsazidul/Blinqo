class SpProfileModel {
  String? id;
  String? userId;
  String? name;
  String? gender;
  String? imageId;
  String? location;
  String? coverPhotoId;
  String? profession;
  String? description;
  int? experience;
  String? createdAt;
  String? updatedAt;
  bool? isPro;
  bool? active;
  bool? enableNotification;
  String? verificationSubmissionId;
  String? groupMessageId;
  String? serviceProviderRole;

  SpProfileModel({
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
  });

  SpProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    gender = json['gender'];
    imageId = json['imageId'];
    location = json['location'];
    coverPhotoId = json['coverPhotoId'];
    profession = json['profession'];
    description = json['description'];
    experience = json['experience'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isPro = json['isPro'];
    active = json['active'];
    enableNotification = json['enableNotification'];
    verificationSubmissionId = json['verificationSubmissionId'];
    groupMessageId = json['groupMessageId'];
    serviceProviderRole = json['serviceProviderRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}
