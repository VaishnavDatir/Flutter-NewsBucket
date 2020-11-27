import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get data {
    // print("Sending data");
    return _prefs.getBool("darkMode");
  }

  Future setdata(bool prefValue) async {
    await _prefs.setBool("darkMode", prefValue);
    // print("PREFS Data Save");
  }
}
