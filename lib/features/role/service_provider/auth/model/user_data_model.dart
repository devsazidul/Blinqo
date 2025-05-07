class UserDataModel {
  String? id;
  String? email;
  List<String>? roles;
  bool? isVerified;
  String? profileId;
  bool? isProfileCreated;

  UserDataModel({
    this.id,
    this.email,
    this.roles,
    this.isVerified,
    this.profileId,
    this.isProfileCreated,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    isVerified = json['isVerified'];
    profileId = json['profileId'];
    isProfileCreated = json['isProfileCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['roles'] = roles ?? [];
    data['isVerified'] = isVerified;
    data['profileId'] = profileId;
    data['isProfileCreated'] = isProfileCreated;
    return data;
  }

  UserDataModel copyWith({
    String? id,
    String? email,
    List<String>? roles,
    bool? isVerified,
    String? profileId,
    bool? isProfileCreated,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      isVerified: isVerified ?? this.isVerified,
      profileId: profileId ?? this.profileId,
      isProfileCreated: isProfileCreated ?? this.isProfileCreated,
    );
  }
}
