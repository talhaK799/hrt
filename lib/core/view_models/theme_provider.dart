import 'package:flutter/material.dart';
import 'package:hart/core/services/theme_shared_prefs.dart';

import '../../locator.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = false;
  final appTheme = locator<SharedPreferencesServices>();

  ThemeProvider() {
    getTheme();
  }

  getTheme() async {
    try {
      isDarkTheme = await appTheme.getTheme();
      notifyListeners();
    } catch (e) {
      print("Error getting theme: $e");
    }
  }

  setTheme(bool value) async {
    isDarkTheme = value;
    await appTheme.setDarkTheme(value);
    notifyListeners();
  }
}