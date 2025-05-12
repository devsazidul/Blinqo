class Avatar {
  String? path;

  Avatar({this.path});

  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(path: json['path'] as String?);

  Map<String, dynamic> toJson() => {'path': path};

  Avatar copyWith({String? path}) {
    return Avatar(path: path ?? this.path);
  }
}
