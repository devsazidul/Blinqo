class SpResponseModel<T extends Object> {
  T? data;
  int? statusCode;
  String? message;
  bool? success;

  SpResponseModel({this.data, this.statusCode, this.message, this.success});

  SpResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    data = json['data'] != null ? fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJson) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = toJson(this.data!);
    } else {
      data['data'] = null;
    }
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}
