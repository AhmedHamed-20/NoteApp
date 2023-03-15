// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  SharedPreferences sharedPreferences;
  CacheHelper({
    required this.sharedPreferences,
  });

  Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else {
      return await sharedPreferences.setBool(key, value);
    }
  }

  dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }
}
