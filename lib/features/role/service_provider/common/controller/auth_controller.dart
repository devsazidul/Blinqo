import 'dart:convert';

import 'package:blinqo/features/role/service_provider/common/constant/constants.dart';
import 'package:blinqo/features/role/service_provider/common/models/sp_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpAuthController {
  static String? token;
  static SpUser? spUser;

  static const String _tokenKey = 'token';
  static const String _spUserKey = 'sp-user';

  // Save user information
  static Future<void> saveUserInformation({
    String? accessToken,
    SpUser? spUser,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (accessToken != null) {
      sharedPreferences.setString(_tokenKey, accessToken);
      token = accessToken;
    }
    if (spUser != null) {
      sharedPreferences.setString(_spUserKey, jsonEncode(spUser.toJson()));
      SpAuthController.spUser = spUser;
    }
  }

  // Get user information
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? tokenString = sharedPreferences.getString(_tokenKey);
    String? spUserString = sharedPreferences.getString(_spUserKey);

    if (tokenString != null) {
      token = tokenString;
    }
    if (spUserString != null) {
      spUser = SpUser.fromJson(jsonDecode(spUserString));
    }
  }

  // Clear user data
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_spUserKey);
    // await sharedPreferences.remove(_userDataKey);
    // await sharedPreferences.remove(_profileInfoDataKey);

    token = null;
    spUser = null;
    // userModel = null;
    // profileInfoModel = null;
  }

  //*----------------- Update token -----------------
  static Future<void> updateToken({required String token}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, token);
    token = token;
  }

  //*----------------- Update sp user -----------------
  static Future<void> updateSpUser({required SpUser spUser}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_spUserKey, jsonEncode(spUser.toJson()));
    spUser = spUser;
  }

  //*----------------- is Logged in -----------------
  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if (token != null) {
      await getUserInformation();
      spUser = SpUser.fromJson(
        jsonDecode(sharedPreferences.getString(_spUserKey) ?? "{}"),
      );
      return spUser?.role?.contains(SpConstants.SERVICE_PROVIDER_ROLE) ?? false;
    }
    return false;
  }

  //*----------------- Logout -----------------
  static Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    spUser = null;
    // userModel = null;
    // profileInfoModel = null;
  }
}
