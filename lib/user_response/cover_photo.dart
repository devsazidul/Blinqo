class CoverPhoto {
  String? path;

  CoverPhoto({this.path});

  factory CoverPhoto.fromJson(Map<String, dynamic> json) =>
      CoverPhoto(path: json['path'] as String?);

  Map<String, dynamic> toJson() => {'path': path};

  CoverPhoto copyWith({String? path}) {
    return CoverPhoto(path: path ?? this.path);
  }
}
