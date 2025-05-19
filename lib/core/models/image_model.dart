class ImageModel {
  // String? id;
  final String path;

  ImageModel({required this.path});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(path: json['path']);
  }

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['path'] = path;
    return data;
  }
}
