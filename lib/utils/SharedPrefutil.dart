import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  SharedPrefUtil._privateConstructor();

  static final SharedPrefUtil _instance = SharedPrefUtil._privateConstructor();

  static SharedPrefUtil get instance => _instance;


  Future<SharedPreferences> get _instanceSP async => await SharedPreferences.getInstance();


  Future<bool> setString(String key, String value) async {
    final SharedPreferences sp = await _instanceSP;
    return sp.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences sp = await _instanceSP;
    return sp.getString(key);
  }
}
