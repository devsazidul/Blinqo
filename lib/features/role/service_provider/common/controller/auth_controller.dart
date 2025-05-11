import 'dart:convert';

import 'package:blinqo/features/role/service_provider/auth/model/user_data_model.dart';
import 'package:blinqo/features/role/service_provider/common/constant/constants.dart';
import 'package:blinqo/features/role/service_provider/common/models/profile_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpAuthController {
  static String? token;
  static UserDataModel? userModel;
  static ProfileInfoModel? profileInfoModel;

  static const String _tokenKey = 'token';
  static const String _userDataKey = 'user-data';
  static const String _profileInfoDataKey = 'profile-info-data';

  // Save user information
  static Future<void> saveUserInformation({
    String? accessToken,
    UserDataModel? user,
    ProfileInfoModel? profileInfo,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (accessToken != null) {
      sharedPreferences.setString(_tokenKey, accessToken);
      token = accessToken;
    }
    if (user != null) {
      sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
      userModel = user;
    }
    if (profileInfo != null) {
      sharedPreferences.setString(
        _profileInfoDataKey,
        jsonEncode(profileInfo.toJson()),
      );

      profileInfoModel = profileInfo;
    }
  }

  //*----------------- Get user information -----------------
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? accessToken = sharedPreferences.getString(_tokenKey);
    token = accessToken;
    // ignore: avoid_print
    print('Loading token from SharedPreferences: $token');

    String? userDataString = sharedPreferences.getString(_userDataKey);
    if (userDataString != null) {
      UserDataModel savedUserData = UserDataModel.fromJson(
        jsonDecode(userDataString),
      );
      userModel = savedUserData;
    }

    String? profileInfoDataString = sharedPreferences.getString(
      _profileInfoDataKey,
    );
    if (profileInfoDataString != null) {
      ProfileInfoModel savedProfileInfo = ProfileInfoModel.fromJson(
        jsonDecode(profileInfoDataString),
      );
      profileInfoModel = savedProfileInfo;
    }
  }

  //*----------------- Update is verified in user model -----------------
  static Future<void> updateUserInformation({
    required bool isProfileCreated,
    required String profileId,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (userModel == null) {
      await getUserInformation();
    }

    if (userModel != null) {
      userModel = userModel!.copyWith(
        isProfileCreated: isProfileCreated,
        profileId: profileId,
      );

      sharedPreferences.setString(
        _userDataKey,
        jsonEncode(userModel!.toJson()),
      );
    }
  }

  // Check if user already logged in
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if (userAccessToken != null) {
      await getUserInformation();
      return userModel?.roles?.contains(SpConstants.SERVICE_PROVIDER_ROLE) ??
          false;
    }
    return false;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userModel = null;
    profileInfoModel = null;
  }
}
