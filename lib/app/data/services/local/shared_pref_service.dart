import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;
  
  // Keys
  static const String _userIdKey = 'userId';
  static const String _roleKey = 'role';
  static const String _tokenKey = 'token';

  // Initialize
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Generic methods
  static Future<void> _saveString(String key, String value) async {
    await init();
    await _prefs?.setString(key, value);
  }

  static Future<String?> _getString(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  // User specific methods
  static Future<void> saveUserId(String userId) => 
      _saveString(_userIdKey, userId);

  static Future<void> saveRole(String role) => 
      _saveString(_roleKey, role);

  static Future<void> saveToken(String token) => 
      _saveString(_tokenKey, token);

  static Future<String?> getUserId() => 
      _getString(_userIdKey);

  static Future<String?> getRole() => 
      _getString(_roleKey);

  static Future<String?> getToken() => 
      _getString(_tokenKey);

  // Clear methods
  static Future<void> clearAll() async {
    await init();
    await _prefs?.clear();
  }

  static Future<void> clearKey(String key) async {
    await init();
    await _prefs?.remove(key);
  }
} 