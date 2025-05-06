import 'dart:convert';

import 'package:blinqo/features/role/service_provider/auth/model/user_model.dart';
import 'package:blinqo/features/role/service_provider/common/models/user_info_model.dart';
import 'package:blinqo/features/role/service_provider/common/models/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpAuthController {
  static String? token;
  static UserInfoModel? userInfoModel;
  static UserModel? userModel;
  static UserProfileModel? userProfileModel;

  static const String _tokenKey = 'token';
  static const String _userInfoDataKey = 'user-info-data';
  static const String _userDataKey = 'user-data';
  static const String _userProfileDataKey = 'user-profile-data';

  // Save user information
  static Future<void> saveUserInformation({
    String? accessToken,
    UserInfoModel? userInfo,
    UserModel? user,
    UserProfileModel? userProfile,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (accessToken != null) {
      sharedPreferences.setString(_tokenKey, accessToken);
    }
    if (userInfo != null) {
      sharedPreferences.setString(
        _userInfoDataKey,
        jsonEncode(userInfo.toJson()),
      );
    }
    if (user != null) {
      sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    }
    if (userProfile != null) {
      sharedPreferences.setString(
        _userProfileDataKey,
        jsonEncode(userProfile.toJson()),
      );
    }

    token = accessToken;
    userModel = user;
    userProfileModel = userProfile;
  }

  // Update user information
  static Future<void> updateUserInformation({
    UserModel? user,
    UserProfileModel? userProfile,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (user != null) {
      sharedPreferences.remove(_userDataKey);
      sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    }
    if (userProfile != null) {
      sharedPreferences.remove(_userProfileDataKey);
      sharedPreferences.setString(
        _userProfileDataKey,
        jsonEncode(userProfile.toJson()),
      );
    }
  }

  // Get user information
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? accessToken = sharedPreferences.getString(_tokenKey);
    token = accessToken;

    String? savedUserInfoString = sharedPreferences.getString(_userInfoDataKey);
    if (savedUserInfoString != null) {
      UserInfoModel savedUserInfo = UserInfoModel.fromJson(
        jsonDecode(savedUserInfoString),
      );
      userInfoModel = savedUserInfo;
    }

    String? savedUserModelString = sharedPreferences.getString(_userDataKey);
    if (savedUserModelString != null) {
      UserModel savedUserModel = UserModel.fromJson(
        jsonDecode(savedUserModelString),
      );
      userModel = savedUserModel;
    }

    String? savedUserProfileString = sharedPreferences.getString(
      _userProfileDataKey,
    );
    if (savedUserProfileString != null) {
      UserProfileModel savedUserProfile = UserProfileModel.fromJson(
        jsonDecode(savedUserProfileString),
      );
      userProfileModel = savedUserProfile;
    }
  }

  // Check if user already logged in
  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if (userAccessToken != null) {
      await getUserInformation();
      return true;
    }
    return false;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userInfoModel = null;
    userModel = null;
    userProfileModel = null;
  }
}
