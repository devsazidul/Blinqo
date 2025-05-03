import 'package:shared_preferences/shared_preferences.dart';

class EvenAuthController {
  static const String _tokenKey = "access_token";

  // Save the auth token
  static Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get the auth token
  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove the auth token (logout)
  static Future<void> removeAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Check if the user is logged in (token exists)
  static Future<bool> isUserLoggedIn() async {
    String? token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }
}
