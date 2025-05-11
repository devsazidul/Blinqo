import 'dart:convert';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/user_all_info_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';

class EventAuthController {
  static const String _tokenKey = "access_token";
  static const String _roleKey = "user_role";
  static const String _userInfo = "user_info";
  static const String _profileInfo = "profile_info";

  static String? token;
  static String? role;
  static EventUser? userInfo;
  static VenueOwnerUserData? profileInfo;

  // Singleton pattern for SharedPreferences
  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveAuthToken(
    String token,
    String role,
    EventUser user,
  ) async {
    try {
      final prefs = await _getPreferences();
      await prefs.setString(_tokenKey, token);
      await prefs.setString(_roleKey, role);
      await prefs.setString(_userInfo, json.encode(user.toJson()));
      token = token;
      role = role;
      userInfo = user;
    } catch (e) {
      EasyLoading.showError("Error saving auth token: $e");
      throw Exception("Error saving auth token");
    }
  }

  // Save user information in SharedPreferences
  static Future<void> saveUserInfo(VenueOwnerUserData user) async {
    try {
      final prefs = await _getPreferences();
      await prefs.setString(_profileInfo, json.encode(user.toJson()));
      profileInfo = user;
    } catch (e) {
      EasyLoading.showError("Error saving user information: $e");
      throw Exception("Error saving user information");
    }
  }

  // get user information from SharedPreferences
  static Future<VenueOwnerUserData?> getUserAllInfo() async {
    try {
      final prefs = await _getPreferences();
      String? userInfoString = prefs.getString(_profileInfo);
      if (userInfoString != null) {
        Map<String, dynamic> userJson = json.decode(userInfoString);
        profileInfo = VenueOwnerUserData.fromJson(userJson);
        return VenueOwnerUserData.fromJson(userJson);
      }
      return null;
    } catch (e) {
      EasyLoading.showError("Error retrieving user information: $e");
      return null;
    }
  }

  // Retrieve the auth token
  static Future<String?> getAuthToken() async {
    try {
      final prefs = await _getPreferences();
      token = prefs.getString(_tokenKey);
      return prefs.getString(_tokenKey);
    } catch (e) {
      EasyLoading.showError("Error retrieving auth token: $e");
      return null;
    }
  }

  // Retrieve the role from SharedPreferences
  static Future<String?> getUserRole() async {
    try {
      final prefs = await _getPreferences();
      role = prefs.getString(_roleKey);
      return prefs.getString(_roleKey);
    } catch (e) {
      EasyLoading.showError("Error retrieving user role: $e");
      return null;
    }
  }

  // Retrieve user information from SharedPreferences
  static Future<EventUser?> getUserInfo() async {
    try {
      final prefs = await _getPreferences();
      String? userInfoString = prefs.getString(_userInfo);
      if (userInfoString != null) {
        Map<String, dynamic> userJson = json.decode(userInfoString);
        userInfo = EventUser.fromJson(userJson);
        return EventUser.fromJson(userJson);
      }
      return null;
    } catch (e) {
      EasyLoading.showError("Error retrieving user information: $e");
      return null;
    }
  }

  // update user information in SharedPreferences
  static Future<void> updateUserInfo(
    String profileId,
    bool isProfileCreated,
  ) async {
    try {
      final prefs = await _getPreferences();
      final currentUser = await getUserInfo();
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          profileId: profileId,
          isProfileCreated: isProfileCreated,
        );
        await prefs.setString(_userInfo, json.encode(updatedUser.toJson()));
        userInfo = updatedUser;
      }
    } catch (e) {
      EasyLoading.showError("Error updating user information: $e");
      throw Exception("Error updating user information");
    }
  }

  // Remove auth token, role, and user information (logout)
  static Future<void> removeAuthToken() async {
    try {
      final prefs = await _getPreferences();
      await prefs.remove(_tokenKey);
      await prefs.remove(_roleKey);
      await prefs.remove(_userInfo);
      await prefs.remove(_profileInfo);
      token = null;
      role = null;
      userInfo = null;
      profileInfo = null;
    } catch (e) {
      EasyLoading.showError("Error removing auth token: $e");
      throw Exception("Error removing auth token");
    }
  }

  // Check if the user is logged in by checking for the token and role
  static Future<bool> isUserLoggedIn() async {
    try {
      userInfo = await getUserInfo();
      profileInfo = await getUserAllInfo();
       token = await getAuthToken();
       role = await getUserRole();
      return token != null &&
          token!.isNotEmpty &&
          role != null &&
          role!.isNotEmpty;
    } catch (e) {
      // ignore: avoid_print
      print("Error checking login status: $e");
      return false;
    }
  }

  // Check if the user has the role
  static Future<bool> userHasRole(String role) async {
    final user = await getUserInfo();
    return user?.hasRole(role) ?? false;
  }
}
