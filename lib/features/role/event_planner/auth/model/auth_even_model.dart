import 'package:blinqo/features/role/event_planner/auth/model/user_even_model.dart';

class AuthEvenModel {
  final AuthModel? data;
  final int statusCode;
  final bool success;
  final String message;

  AuthEvenModel({
    this.data,
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory AuthEvenModel.fromJson(Map<String, dynamic> json) {
    return AuthEvenModel(
      data: json['data'] != null ? AuthModel.fromJson(json['data']) : null,
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

class AuthModel {
  final String accessToken;
  final UserEvenModel user;

  AuthModel({required this.accessToken, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'] ?? '',
      user: UserEvenModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'user': user.toJson()};
  }
}
