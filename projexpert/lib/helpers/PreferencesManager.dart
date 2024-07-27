import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();
  factory PreferencesManager() => _instance;
  PreferencesManager._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getAccessToken() async {
    return _prefs?.getString('access_token');
  }

  Future<void> setAccessToken(String token) async {
    await _prefs?.setString('access_token', token);
  }

  Future<String?> getUserName() async {
    return _prefs?.getString('user_name');
  }

  Future<void> setUserName(String name) async {
    await _prefs?.setString('user_name', name);
  }

  Future<String?> getUserEmail() async {
    return _prefs?.getString('user_email');
  }

  Future<void> setUserEmail(String email) async {
    await _prefs?.setString('user_email', email);
  }
}