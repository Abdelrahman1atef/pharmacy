import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }
  static Future<void> saveThemeMode(String mode) async {
    await saveData(key: 'theme_mode', value: mode);
  }
  // Method to get theme mode
  static String? getThemeMode() {
    return getData(key: 'theme_mode') as String?;
  }
  static Future<bool> removeData({required String key}) async {
    return sharedPreferences.remove(key);
  }
  
  static Future<void> saveToken(String token) async {
    await saveData(key: 'token', value: token);
  }

  static String? getToken() {
    final token = getData(key: 'token') as String?;
    return token?.isNotEmpty == true ? token : null;
  }

  static bool hasValidToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearToken() async {
    await removeData(key: 'token');
  }

}
