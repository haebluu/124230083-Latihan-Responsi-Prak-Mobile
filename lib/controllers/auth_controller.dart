import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/hive_service.dart';
import '../services/shared_pref_service.dart';

class AuthController extends ChangeNotifier {
  final HiveService _hiveService = HiveService();
  final SharedPrefService _sharedPrefService = SharedPrefService();

  String? _currentUsername;
  String? get currentUsername => _currentUsername;

  // Cek Session Login
  Future<void> checkLoginStatus() async {
    _currentUsername = await _sharedPrefService.getSession();
    notifyListeners();
  }

  // Register
  Future<String?> register(String username, String password) async {
    final existingUser = await _hiveService.getUser(username);
    if (existingUser != null) {
      return 'Username already exists.';
    }

    final newUser = UserModel(username: username, password: password);
    await _hiveService.saveUser(newUser);
    return null; // Success
  }

  // Login
  Future<String?> login(String username, String password) async {
    final user = await _hiveService.getUser(username);

    if (user == null) {
      return 'Username not found.';
    }

    if (user.password != password) {
      return 'Incorrect password.';
    }

    await _sharedPrefService.saveSession(username);
    _currentUsername = username;
    notifyListeners();
    return null; // Success
  }

  // Logout
  Future<void> logout() async {
    await _sharedPrefService.deleteSession();
    _currentUsername = null;
    notifyListeners();
  }
}