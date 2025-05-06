class ResponseModel<T extends Object> {
  final T? data;
  final int statusCode;
  final bool success;
  final String message;

  ResponseModel({
    this.data,
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return ResponseModel(
      data: json['data'] != null ? fromJson(json['data']) : null,
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJson) {
    return {
      'data': data != null ? toJson(data!) : null,
      'statusCode': statusCode,
      'success': success,
      'message': message,
    };
  }
}
