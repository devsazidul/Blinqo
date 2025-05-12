import 'profile.dart';

class Data {
  String? id;
  String? email;
  String? phone;
  String? name;
  List<String>? role;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    name: json['name'] as String?,
    role: json['role'] as List<String>?,
    isVerified: json['isVerified'] as bool?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    updatedAt:
        json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
    profile:
        json['profile'] == null
            ? null
            : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'phone': phone,
    'name': name,
    'role': role,
    'isVerified': isVerified,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'profile': profile?.toJson(),
  };

  Data copyWith({
    String? id,
    String? email,
    String? phone,
    String? name,
    List<String>? role,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    Profile? profile,
  }) {
    return Data(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profile: profile ?? this.profile,
    );
  }
}
