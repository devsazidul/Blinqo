class ResponseModel {
  final List<EventPreferenceModel> data;
  final String message;
  final int statusCode;
  final bool success;

  ResponseModel({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];
    final List<EventPreferenceModel> data =
        dataList
            .map(
              (item) =>
                  EventPreferenceModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();

    return ResponseModel(
      data: data,
      message: json['message'],
      statusCode: json['statusCode'],
      success: json['success'],
    );
  }
}

class EventPreferenceModel {
  final String id;
  final String name;
  final AvatarModel avatar;

  EventPreferenceModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory EventPreferenceModel.fromJson(Map<String, dynamic> json) {
    return EventPreferenceModel(
      id: json['id'],
      name: json['name'],
      avatar: AvatarModel.fromJson(json['avatar']),
    );
  }
}

class AvatarModel {
  final String path;

  AvatarModel({required this.path});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(path: json['path']);
  }
}
