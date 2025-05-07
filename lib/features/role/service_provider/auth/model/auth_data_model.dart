import 'package:blinqo/features/role/service_provider/auth/model/user_data_model.dart';

class AuthDataModel {
  String? accessToken;
  UserDataModel? user;

  AuthDataModel({this.accessToken, this.user});

  AuthDataModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    user = json['user'] != null ? UserDataModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
