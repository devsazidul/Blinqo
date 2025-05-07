class LoginResponse {
  final Data? data;
  final int? statusCode;
  final String? message;
  final bool? success;

  LoginResponse({this.data, this.statusCode, this.message, this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
    );
  }
}

class Data {
  final String? accessToken;
  final EventUser? user;

  Data({this.accessToken, this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json['access_token'],
      user: json['user'] != null ? EventUser.fromJson(json['user']) : null,
    );
  }
}

class EventUser {
  final String? id;
  final String? email;
  final List<String>? roles;
  final bool? isVerified;
  final String? profileId;
  final bool? isProfileCreated;

  EventUser({
    this.id,
    this.email,
    this.roles,
    this.isVerified,
    this.profileId,
    this.isProfileCreated,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'roles': roles,
      'isVerified': isVerified,
      'profileId': profileId,
      'isProfileCreated': isProfileCreated,
    };
  }

  factory EventUser.fromJson(Map<String, dynamic> json) {
    return EventUser(
      id: json['id'],
      email: json['email'],
      roles: List<String>.from(json['roles'] ?? []),
      isVerified: json['isVerified'],
      profileId: json['profileId'],
      isProfileCreated: json['isProfileCreated'],
    );
  }

  //Check if the user's role matches
  bool hasRole(String role) {
    return roles?.contains(role) ?? false;
  }
}
