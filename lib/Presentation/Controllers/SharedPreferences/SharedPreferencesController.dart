import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController {
  late SharedPreferences _prefs;

  String token = '';
  String role = '';
  bool isFirstTime = true;

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
    role = _prefs.getString('role') ?? '';
    isFirstTime = _prefs.getBool('isFirstTime') ?? false;
  }

  // Save a value
  Future<void> saveData(String key, String value) async {
    await _prefs.setString(key, value);
    if (key == 'token') {
      token = value;
    }
    if (key == 'role') {
      role = value;
    }
  }

  // Retrieve a value
  Future<String?> getData(String key) async {
    return _prefs.getString(key);
  }

  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
    if (key == 'isFirstTime') {
      isFirstTime = value;
    }
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
    role = '';
    isFirstTime = false;
  }
}
