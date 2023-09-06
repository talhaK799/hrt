import 'package:flutter/material.dart';

class AppColors {
  // static const lightBrown = Color(0xFF5e3323);
  // static const darkBrown = Color(0xFF2b1005);

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      // primarySwatch: Colors.blue,
      // primaryColor: isDarkTheme ? Colors.white : lightBrown,
      // accentColor: lightBrown,
      // canvasColor: lightBrown,
      // cursorColor: Colors.yellow,
      // back groundColor: isDarkTheme ? Colors.black54 : Colors.white,

      backgroundColor: isDarkTheme ? Colors.black87 : Color(0xffFFFFFF),
      cardColor: isDarkTheme ? Colors.black87 : Color(0xffFFFFFF),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: isDarkTheme ? Color(0xffFFFFFF) : Colors.black,
        ),
      ),
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Color(0xffFFFFFF),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.yellow,
      ),
    );
  }
}
