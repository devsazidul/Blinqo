// class EEventPreferenceModel {
//   final String? id;
//   final String? name;
//   final Avatar? avatar;

//   EEventPreferenceModel({this.id, this.name, this.avatar});

//   factory EEventPreferenceModel.fromJson(Map<String, dynamic> json) {
//     return EEventPreferenceModel(
//       id: json['id'] as String?,
//       name: json['name'] as String?,
//       avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     if (avatar != null) {
//       data['avatar'] = avatar!.toJson();
//     }
//     return data;
//   }
// }

// class Avatar {
//   final String? path;

//   Avatar({this.path});

//   factory Avatar.fromJson(Map<String, dynamic> json) {
//     return Avatar(
//       path: json['path'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['path'] = path;
//     return data;
//   }
// }


class EEventPreferenceModel {
  final String? id;
  final String? name;
  final Avatar? avatar;

  EEventPreferenceModel({this.id, this.name, this.avatar});

  factory EEventPreferenceModel.fromJson(Map<String, dynamic> json) {
    return EEventPreferenceModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar?.toJson(),
  };
}

class Avatar {
  final String? path;

  Avatar({this.path});

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    path: json['path'] as String?,
  );

  Map<String, dynamic> toJson() => {'path': path};
}