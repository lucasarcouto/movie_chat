import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesLocalDataSource {
  Future<String> getString(String key, String defVal);
  Future<bool> putString(String key, String value);
}

class PreferencesLocalDataSourceImpl implements PreferencesLocalDataSource {
  @override
  Future<String> getString(String key, String defVal) async {
    var preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key)) {
      return preferences.getString(key) ?? "";
    }
    return defVal;
  }

  @override
  Future<bool> putString(String key, String value) async =>
      (await SharedPreferences.getInstance()).setString(key, value);
}
