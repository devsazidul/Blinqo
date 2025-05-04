import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EvenAuthController {
  // Define constant keys for storing and retrieving data
  static const String _tokenKey = "access_token";
  static const String _roleKey = "user_role";

  // Singleton pattern for SharedPreferences
  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  // Save auth token and role after successful login
  static Future<void> saveAuthToken(String token, String role) async {
    try {
      final prefs = await _getPreferences();
      await prefs.setString(_tokenKey, token);
      await prefs.setString(_roleKey, role);
    } catch (e) {
      print("Error saving auth token: $e");
      throw Exception("Error saving auth token");
    }
  }

  // Retrieve the auth token
  static Future<String?> getAuthToken() async {
    try {
      final prefs = await _getPreferences();
      return prefs.getString(_tokenKey);
    } catch (e) {
      print("Error retrieving auth token: $e");
      return null;
    }
  }

  // Retrieve the role from SharedPreferences
  static Future<String?> getUserRole() async {
    try {
      final prefs = await _getPreferences();
      return prefs.getString(_roleKey);
    } catch (e) {
      print("Error retrieving user role: $e");
      return null;
    }
  }

  // Remove auth token (logout)
  static Future<void> removeAuthToken() async {
    try {
      final prefs = await _getPreferences();
      await prefs.remove(_tokenKey);
      await prefs.remove(_roleKey);
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
      print("Error checking login status: $e");
      return false;
    }
  }

// Optionally, you can add additional helper methods for user data retrieval or storage, like userId or email.
}
