import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferenceDataSource {
  Future<bool?> setString(String key, String value);

  String? getString(String key);

  Future<bool?> setInt(String key, int value);

  int? getInt(String key);

  Future<bool?> setBool(String key, bool value);

  bool? getBool(String key);
}

class SharedPreferenceDataSourceImpl extends SharedPreferenceDataSource {
  SharedPreferences? sharedPreferences;

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool?> setString(String key, String value) async {
    return await sharedPreferences?.setString(key, value);
  }

  @override
  String? getString(String key) {
    return sharedPreferences?.getString(key);
  }

  @override
  int? getInt(String key) {
    return sharedPreferences?.getInt(key);
  }

  @override
  Future<bool?> setInt(String key, int value) async {
    return await sharedPreferences?.setInt(key, value);
  }

  @override
  bool? getBool(String key) {
    return sharedPreferences?.getBool(key);
  }

  @override
  Future<bool?> setBool(String key, bool value) async {
    return await sharedPreferences?.setBool(key, value);
  }
}
