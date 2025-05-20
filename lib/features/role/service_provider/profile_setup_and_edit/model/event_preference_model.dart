class EventPreferenceModel {
  String? id;
  String? name;
  Avatar? avatar;

  EventPreferenceModel({this.id, this.name, this.avatar});

  EventPreferenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    return data;
  }
}

class Avatar {
  String? path;

  Avatar({this.path});

  Avatar.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    return data;
  }
}
