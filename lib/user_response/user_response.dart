import 'data.dart';

class UserResponse {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  UserResponse({this.statusCode, this.success, this.message, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    statusCode: json['statusCode'] as int?,
    success: json['success'] as bool?,
    message: json['message'] as String?,
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };

  UserResponse copyWith({
    int? statusCode,
    bool? success,
    String? message,
    Data? data,
  }) {
    return UserResponse(
      statusCode: statusCode ?? this.statusCode,
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
