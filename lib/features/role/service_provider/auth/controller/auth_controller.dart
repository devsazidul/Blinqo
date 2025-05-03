import 'package:shared_preferences/shared_preferences.dart';

class SpAuthController {
  final String _accessTokenKey = 'accessToken';

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<void> saveAccessToken(String token) async {
    _accessToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    _accessToken = token;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<void> clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    _accessToken = null;
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_accessTokenKey);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    _accessToken = null;
  }
}
