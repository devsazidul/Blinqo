import 'package:blinqo/features/role/service_provider/auth/model/user_model.dart';

class ResponseModel {
  final SignUpModel? data;
  final int statusCode;
  final bool success;
  final String message;

  ResponseModel({
    this.data,
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      data: json['data'] != null ? SignUpModel.fromJson(json['data']) : null,
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'statusCode': statusCode,
      'success': success,
      'message': message,
    };
  }
}

class SignUpModel {
  final String accessToken;
  final UserModel user;

  SignUpModel({required this.accessToken, required this.user});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      accessToken: json['access_token'] ?? '',
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'user': user.toJson()};
  }
}
