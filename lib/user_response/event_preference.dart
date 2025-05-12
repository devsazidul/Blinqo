import 'avatar.dart';

class EventPreference {
  String? id;
  String? name;
  Avatar? avatar;

  EventPreference({this.id, this.name, this.avatar});

  factory EventPreference.fromJson(Map<String, dynamic> json) {
    return EventPreference(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar:
          json['avatar'] == null
              ? null
              : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar?.toJson(),
  };

  EventPreference copyWith({String? id, String? name, Avatar? avatar}) {
    return EventPreference(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
