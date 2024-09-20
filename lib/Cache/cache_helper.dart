import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences; // object

  // function to initialize sharedPreferences
  static initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // functions to save data
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else {
      return await sharedPreferences!.setInt(key, value);
    }
  }

  //function to Get data
  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  //function to Remove data
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  //function Check key
  static Future<bool> containKey({required String key}) async {
    return sharedPreferences!.containsKey(key);
  }

  //function clear everything
  static Future<bool> clear() async {
    return await sharedPreferences!.clear();
  }
}
