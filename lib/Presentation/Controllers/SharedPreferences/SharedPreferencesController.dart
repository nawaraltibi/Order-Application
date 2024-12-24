import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController {
  late SharedPreferences _prefs;

  String token = '';

  // Constructor to initialize SharedPreferences
  @override
  void onInit() {
    super.onInit();
    _initializePrefs();
  }

  // Initialize SharedPreferences
  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token') ?? '';
  }

  // Save a value
  Future<void> saveData(String key, String value) async {
    await _prefs.setString(key, value);
    if (key == 'token') {
      token = value;
    }
  }

  // Retrieve a value
  Future<String?> getData(String key) async {
    return _prefs.getString(key);
  }

  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Retrieve a boolean value
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  // Save an integer value
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // Retrieve an integer value
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  // Clear all data
  Future<void> clearData() async {
    await _prefs.clear();
    token = '';
    _prefs.setBool("isFirstTime", false);
  }
}
