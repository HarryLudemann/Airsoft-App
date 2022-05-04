import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class FontColorPreferences {
  static const PREF_KEY = "app_fonts_color";

  // function to convert a color

  setFontColor(Color value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value.value.toString());
  }

  getFontColor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString(PREF_KEY);
    if (theme != null) {
      return Color(int.parse(theme));
    }
  }
}
