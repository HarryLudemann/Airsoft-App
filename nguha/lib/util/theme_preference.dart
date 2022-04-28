import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemePreferences {
  static const PREF_KEY = "app_theme";

  // function to convert a color

  setTheme(Color value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value.value.toString());
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString(PREF_KEY);
    if (theme != null) {
      return Color(int.parse(theme));
    }
  }
}
