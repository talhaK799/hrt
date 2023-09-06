import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static const THEME_STATUS = "theme_status";
  bool isDarkTheme = false;

  SharedPreferencesServices() {
    intit();
  }

  intit() {
    getTheme();
  }

  setDarkTheme(bool value) async {
    try {
      isDarkTheme = value;
      print("setDarkTheme: $value");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(THEME_STATUS, value);
    } catch (e) {
      print(e);
    }
  }

  getTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isDarkTheme = prefs.getBool(THEME_STATUS) ?? false;
      print("isDarkTheme: $isDarkTheme");
      return isDarkTheme;
    } catch (e) {
      print(e);
    }
  }
}