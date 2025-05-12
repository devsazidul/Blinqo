import 'cover_photo.dart';
import 'event_preference.dart';
import 'image.dart';

class Profile {
  String? id;
  String? userId;
  String? name;
  String? gender;
  String? imageId;
  String? location;
  String? coverPhotoId;
  dynamic profession;
  String? description;
  int? experience;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isPro;
  bool? active;
  bool? enableNotification;
  dynamic verificationSubmissionId;
  dynamic groupMessageId;
  String? serviceProviderRole;
  Image? image;
  CoverPhoto? coverPhoto;
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

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    name: json['name'] as String?,
    gender: json['gender'] as String?,
    imageId: json['imageId'] as String?,
    location: json['location'] as String?,
    coverPhotoId: json['coverPhotoId'] as String?,
    profession: json['profession'] as dynamic,
    description: json['description'] as String?,
    experience: json['experience'] as int?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    updatedAt:
        json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
    isPro: json['isPro'] as bool?,
    active: json['active'] as bool?,
    enableNotification: json['enableNotification'] as bool?,
    verificationSubmissionId: json['verificationSubmissionId'] as dynamic,
    groupMessageId: json['groupMessageId'] as dynamic,
    serviceProviderRole: json['serviceProviderRole'] as String?,
    image:
        json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
    coverPhoto:
        json['coverPhoto'] == null
            ? null
            : CoverPhoto.fromJson(json['coverPhoto'] as Map<String, dynamic>),
    eventPreference:
        (json['eventPreference'] as List<dynamic>?)
            ?.map((e) => EventPreference.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
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
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'isPro': isPro,
    'active': active,
    'enableNotification': enableNotification,
    'verificationSubmissionId': verificationSubmissionId,
    'groupMessageId': groupMessageId,
    'serviceProviderRole': serviceProviderRole,
    'image': image?.toJson(),
    'coverPhoto': coverPhoto?.toJson(),
    'eventPreference': eventPreference?.map((e) => e.toJson()).toList(),
  };

  Profile copyWith({
    String? id,
    String? userId,
    String? name,
    String? gender,
    String? imageId,
    String? location,
    String? coverPhotoId,
    dynamic profession,
    String? description,
    int? experience,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPro,
    bool? active,
    bool? enableNotification,
    dynamic verificationSubmissionId,
    dynamic groupMessageId,
    String? serviceProviderRole,
    Image? image,
    CoverPhoto? coverPhoto,
    List<EventPreference>? eventPreference,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      imageId: imageId ?? this.imageId,
      location: location ?? this.location,
      coverPhotoId: coverPhotoId ?? this.coverPhotoId,
      profession: profession ?? this.profession,
      description: description ?? this.description,
      experience: experience ?? this.experience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPro: isPro ?? this.isPro,
      active: active ?? this.active,
      enableNotification: enableNotification ?? this.enableNotification,
      verificationSubmissionId:
          verificationSubmissionId ?? this.verificationSubmissionId,
      groupMessageId: groupMessageId ?? this.groupMessageId,
      serviceProviderRole: serviceProviderRole ?? this.serviceProviderRole,
      image: image ?? this.image,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      eventPreference: eventPreference ?? this.eventPreference,
    );
  }
}
