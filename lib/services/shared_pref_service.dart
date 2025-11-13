import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _sessionKey = 'sessionUsername';
  static const String _favoritesKey = 'favoritesAnime';
  static const String _profileImageKey = 'profileImagePath';

  Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, username);
  }

  Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionKey);
  }

  Future<void> deleteSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> saveFavorites(List<String> favoritesJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }

  Future<void> saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }
}