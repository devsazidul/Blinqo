import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';

class EvenAuthController {

  static const String _tokenKey = "access_token";
  static const String _roleKey = "user_role";
  static const String userInfo = "user_info";

  // Singleton pattern for SharedPreferences
  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }


  static Future<void> saveAuthToken(String token, String role, EventUser user) async {
    try {
      final prefs = await _getPreferences();
      await prefs.setString(_tokenKey, token);
      await prefs.setString(_roleKey, role);
      await prefs.setString(userInfo, json.encode(user.toJson())); // Save user data
    } catch (e) {
      EasyLoading.showError("Error saving auth token: $e");
      throw Exception("Error saving auth token");
    }
  }

  // Retrieve the auth token
  static Future<String?> getAuthToken() async {
    try {
      final prefs = await _getPreferences();
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
      String? userInfoString = prefs.getString(userInfo);
      if (userInfoString != null) {
        Map<String, dynamic> userJson = json.decode(userInfoString);
        return EventUser.fromJson(userJson);
      }
      return null;
    } catch (e) {
      EasyLoading.showError("Error retrieving user information: $e");
      return null;
    }
  }

  // Remove auth token, role, and user information (logout)
  static Future<void> removeAuthToken() async {
    try {
      final prefs = await _getPreferences();
      await prefs.remove(_tokenKey);
      await prefs.remove(_roleKey);
      await prefs.remove(userInfo);
    } catch (e) {
      EasyLoading.showError("Error removing auth token: $e");
      throw Exception("Error removing auth token");
    }
  }

  // Check if the user is logged in by checking for the token and role
  static Future<bool> isUserLoggedIn() async {
    try {
      final token = await getAuthToken();
      final role = await getUserRole();
      // Ensure both token and role are present
      return token != null && token.isNotEmpty && role != null && role.isNotEmpty;
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
