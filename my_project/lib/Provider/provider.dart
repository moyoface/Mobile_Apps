import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIProvider extends ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  String? savedUsername;
  late SharedPreferences storage;

  toggleCheck() {
    _isChecked = !isChecked;
    notifyListeners();
  }

  Future<void> setRememberMe(String username) async {
    storage = await SharedPreferences.getInstance();
    await storage.setBool('rememberMe', true);
    await storage.setString('savedUsername', username);
    _rememberMe = true;
    savedUsername = username;
    notifyListeners();
  }

  Future<void> clearRememberMe() async {
    storage = await SharedPreferences.getInstance();
    await storage.remove('rememberMe');
    await storage.remove('savedUsername');
    _rememberMe = false;
    savedUsername = null;
    notifyListeners();
  }

  Future<void> initStorage() async {
    storage = await SharedPreferences.getInstance();
    _rememberMe = storage.getBool('rememberMe') ?? false;
    savedUsername = storage.getString('savedUsername');
    notifyListeners();
  }
}
